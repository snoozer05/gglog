#coding: utf-8
require 'thor'
require 'rugged'
require 'pager'
require 'gglog/database'
require 'gglog/repository'
require 'gglog/commit_message_decorator'

module Gglog
  class Command < Thor
    include Pager

    desc 'register [CLONE URL]', 'Register git repository on clone url to gglog target'
    def register(clone_url)
      repository_name = File.basename(clone_url, '.git')
      registration_path = repository_path(repository_name)
      repository = Repository.checkout(clone_url, registration_path)

      setup_database unless File.exists?(db_home)
      Gglog::Database.open(db_home, 'utf-8') do |db|
        repository.commit_messages.each do |commit_message|
          db.add_commit_message(commit_message)
        end
      end
    end

    desc 'list', 'List git repositories of gglog target'
    def list
      registered_repositories.each do |repository|
        say repository.name
      end
    end

    desc 'search [WORDS]', 'Search commit message'
    def search(words)
      commit_messages = []

      setup_database unless File.exists?(db_home)
      Gglog::Database.open(db_home, 'utf-8') do |db|
        commit_messages = db.search(words).map do |cm|
          cm.extend CommitMessageDecorator
        end
      end

      page
      commit_messages.each do |commit_message|
        say commit_message.display
      end
    end

    desc 'show [REPOSITORY_NAME] [SHA]', 'Show commit message'
    def show(repository_name, sha)
      repository = Repository.new(repository_path(repository_name))
      commit_message = repository.commit_message(sha).tap do |cm|
        cm.extend CommitMessageDecorator
      end

      page
      say commit_message.display_detail
    end

    desc 'sync', 'Sync git repositories of gglog target'
    def sync
      registered_repositories.each do |repository|
        repository.pull
      end

      setup_database unless File.exists?(db_home)
      Gglog::Database.open(db_home, 'utf-8') do |db|
        db.recreate
        registered_repositories.each do |repository|
          repository.commit_messages.each do |commit_message|
            db.add_commit_message(commit_message)
          end
        end
      end
    end

    private
    def dot_gglog
      File.expand_path("~/.gglog")
    end

    def registered_repositories_path
      File.join(dot_gglog, "repositories")
    end

    def repository_path(name)
      File.join(registered_repositories_path, name)
    end

    def db_home
      File.join(dot_gglog, "db")
    end

    def registered_repositories
      Dir[File.join(registered_repositories_path, "*")].map do |path|
        Repository.new(path)
      end
    end

    def setup_database
      FileUtils.mkdir_p(db_home)
      Gglog::Database.open(db_home, 'utf-8') do |db|
        db.recreate
      end
    end
  end
end
