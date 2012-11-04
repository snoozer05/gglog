# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "gglog/version"

Gem::Specification.new do |s|
  s.name        = "gglog"
  s.version     = Gglog::VERSION
  s.authors     = ["SHIMADA Koji"]
  s.email       = ["koji.shimada@enishi-tech.com"]
  s.homepage    = "http://gglog.github.com/"
  s.summary     = %q{Your partner for finding a good commit message.}
  s.description = %q{Your partner for finding a good commit message.}

  s.rubyforge_project = "gglog"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 1.9.3'

  s.add_runtime_dependency 'thor', ['>= 0.16.0']
  s.add_runtime_dependency 'bundler', ['>= 1.2']
  s.add_runtime_dependency 'rroonga', ['>= 2.0.6']
  s.add_runtime_dependency 'rugged', ['>= 0.16.0']
  s.add_runtime_dependency 'rainbow'
  s.add_runtime_dependency 'pager'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
