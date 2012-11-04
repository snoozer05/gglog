#coding: utf-8
require 'thor'
require 'rugged'
require 'pager'
require 'gglog/database'
require 'gglog/commit_message'
require 'gglog/commit_message_decorator'

module Gglog
  class Command < Thor
    include Pager

    desc 'init', 'Initialize gglog'
    def init
      FileUtils.mkdir_p(db_home)
      Gglog::Database.open(db_home, 'utf-8') do |db|
        db.recreate
      end
    end

    desc 'register [CLONE URL]', 'Register git repository on clone url to gglog target'
    def register(clone_url)
      repository_name = File.basename(clone_url, '.git')
      registration_path = File.join(registered_repositories_path, repository_name)
      FileUtils.mkdir_p(registration_path)
      Dir.chdir(registration_path) do
        system "git", "clone", "--quiet", clone_url, registration_path
      end

      Gglog::Database.open(db_home, 'utf-8') do |db|
        commit_messages_on(registration_path).each do |commit_message|
          db.add_commit_message(commit_message)
        end
      end
    end

    desc 'list', 'List git repositories of gglog target'
    def list
      registered_repositories.each do |repository|
        say File.basename(repository)
      end
    end

    desc 'search [WORDS]', 'Search commit message'
    def search(words)
      commit_messages = Gglog::Database.open(db_home, 'utf-8') do |db|
        db.search(words).map {|cm| cm.extend CommitMessageDecorator }
      end
      page
      commit_messages.each do |commit_message|
        say commit_message.display
      end
    end

    desc 'show [REPOSITORY_NAME] [SHA]', 'Show commit message'
    def show(repository_name, sha)
      repository_path = File.join(registered_repositories_path, repository_name)
      commit_message = commit_message(repository_path, sha)
      page
      say ''
      say commit_message.first_line.bright
      say ''
      say commit_message.body
      say ''
    end

    desc 'sync', 'Sync git repositories of gglog target'
    def sync
      registered_repositories.each do |repository|
        Dir.chdir(repository) do
          system "git", "reset", "--hard", "--quiet"
          system "git", "pull", "--force", "--quiet", "origin", "master"
        end
      end

      Gglog::Database.open(db_home, 'utf-8') do |db|
        db.recreate
        registered_repositories.each do |repository|
          commit_messages_on(repository).each do |commit_message|
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

    def db_home
      File.join(dot_gglog, "db")
    end

    def registered_repositories
      Dir[File.join(registered_repositories_path, "*")]
    end

    def commits_on(repository)
      repo = Rugged::Repository.new(repository)
      walker = Rugged::Walker.new(repo)
      walker.push(repo.lookup(repo.head.target).oid)
      walker.sorting(Rugged::SORT_REVERSE)
      walker
    end

    def commit_messages_on(repository)
      commits_on(repository).map do |commit|
        commit_message =
          CommitMessage.new_from_commit_object(commit, File.basename(repository))
        commit_message.extend CommitMessageDecorator
      end
    end

    def commit_message(repository, sha)
      repo = Rugged::Repository.new(repository)
      commit = repo.lookup(sha)
      CommitMessage.new_from_commit_object(commit, File.basename(repository))
    end
  end
end
