#coding: utf-8
require 'rugged'
require 'gglog/commit_message'

module Gglog
  class Repository
    class << self
      def checkout(clone_url, path)
        FileUtils.mkdir_p(path)
        Dir.chdir(path) do
          system "git", "clone", "--quiet", clone_url, path
        end
        new(path)
      end
    end

    def initialize(path)
      @path = path
      @repo = Rugged::Repository.new(path)
    end

    def name
      File.basename(@path)
    end

    def commit_messages
      commits.map do |commit|
        CommitMessage.new_from_commit_object(commit, name)
      end
    end

    def show(sha)
      Dir.chdir(@path) do
        system "git", "show", sha
      end
    end

    def pull
      Dir.chdir(@path) do
        system "git", "reset", "--hard", "--quiet"
        system "git", "pull", "--force", "--quiet", "origin", "master"
      end
    end

    private
    def commits
      walker = Rugged::Walker.new(@repo)
      walker.push(@repo.lookup(@repo.head.target).oid)
      walker.sorting(Rugged::SORT_REVERSE)
      walker
    end
  end
end
