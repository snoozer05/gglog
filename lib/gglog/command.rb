#coding: utf-8
require 'thor'

module Gglog
  class Command < Thor
    desc 'register [CLONE URL]', 'Register git repository on clone url to gglog target'
    def register(clone_url)
      #TODO
    end

    desc 'list', 'List git repositories of gglog target'
    def list
      #TODO
    end

    desc 'search [WORDS]', 'Search commit message'
    def search(words)
      #TODO
    end

    desc 'yaku [JAPANESE WORDS]', 'Translate commit message'
    def yaku(japanese_words)
      #TODO
    end

    desc 'sync', 'Sync git repositories of gglog target'
    def sync
      #TODO
    end
  end
end
