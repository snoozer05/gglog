require 'bundler'
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = true
end

task :default => :spec
