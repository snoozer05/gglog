#coding: utf-8
module Gglog
  class CommitMessage
    class << self
      def new_from_commit_object(commit, repository_name)
        first_line, _, body = commit.message.split("\n", 3)
        self.new(first_line, body, repository_name, commit.oid)
      end

      def new_from_record(commit_message)
        self.new(commit_message.first_line, commit_message.body,
                 commit_message.repository, commit_message.sha)
      end
    end
    attr_reader   :first_line, :body
    attr_reader   :repository, :sha
    attr_accessor :first_line_included_snippet

    def initialize(first_line, body, repository, sha)
      @first_line = first_line || ""
      @body = body || ""
      @repository = repository || ""
      @sha = sha || ""

      @first_line = @first_line.force_encoding('UTF-8')
      @body = @body.force_encoding('UTF-8')
      @repository = @repository.force_encoding('utf-8')
      @sha = @sha.force_encoding('utf-8')
    end
  end
end
