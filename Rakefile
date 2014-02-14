require 'bundler'
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "features --format pretty"
end

task :default => :cucumber
