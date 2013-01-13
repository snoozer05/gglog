#coding: utf-8
require 'groonga'

module Gglog
  class Database
    class << self
      def open(base_path, encoding, &blk)
        if blk
          Database.new.open(base_path, encoding, &blk)
        else
          Database.new.open(base_path, encoding)
        end
      end
    end

    def initilize
      @database = nil
    end

    def open(base_path, encoding)
      reset_groonga_context(encoding)
      open_groonga_db(base_path)
      if block_given?
        begin
          yield(self)
        ensure
          close
        end
      end
    end

    def close
      close_groonga_db
    end

    def search(words)
      records_selected = Groonga["commit_messages"].select do |record|
        conditions = [record.first_line =~ words]
      end
      records = records_selected.sort([
        { key: "_score", order: 'descending' },
        { key: "repository", order: 'ascending' },
        { key: "first_line", order: 'ascending' }
      ])
      # convert to Array from Groonga::Array to keep before 2.1.0 style
      #  see http://ranguba.org/rroonga/ja/Groonga/Table.html#sort-instance_method
      records = records.collect {|record| record.value }

      filtered_records = filter_records(records)
      convert_records_to_commit_messages(filtered_records)
    end

    def recreate
      remove_tables
      create_tables
    end

    def add_commit_message(commit_message)
      Groonga["commit_messages"].add(
        first_line: commit_message.first_line,
        body: commit_message.body,
        repository: commit_message.repository,
        sha: commit_message.sha
      )
    end

    private
    def open_groonga_db(base_path)
      close
      path = File.join(base_path, "gglog.db")
      if File.exist?(path)
        @database =Groonga::Database.open(path)
      else
        FileUtils.mkdir_p(base_path)
        @database =Groonga::Database.create(:path => path)
      end
    end

    def close_groonga_db
      unless @database.nil?
        @database.close unless @database.closed?
        @database = nil
      end
    end

    def reset_groonga_context(encoding)
      Groonga::Context.default_options = { encoding: encoding }
      Groonga::Context.default = nil
    end

    def create_tables
      Groonga::Schema.define do |schema|
        schema.create_table("commit_messages") do |table|
          table.short_text("first_line")
          table.text("body")
          table.short_text("repository")
          table.short_text("sha")
        end
        schema.create_table("terms",
                            type: :patricia_trie,
                            key_normalize: true,
                            default_tokenizer: "TokenBigram"
                           ) do |table|
          table.index("commit_messages.first_line")
        end
      end
    end

    def remove_tables
      Groonga::Schema.define do |schema|
        %w(commit_messages terms).each do |table|
          schema.remove_table(table) if Groonga[table]
        end
      end
    end

    def filter_records(records)
      records.reject do |record|
        commit_message = record.key
        commit_message.first_line =~ /^Merge (pull request|branch).*/
      end
    end

    def convert_records_to_commit_messages(records)
      records.map do |record|
        commit_message = record.key
        CommitMessage.new_from_record(commit_message)
      end
    end
  end
end
