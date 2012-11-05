#coding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'aruba/cucumber'
require 'gglog'
require 'tmpdir'

Before do
  @gglog_home = Dir.mktmpdir
  @aruba_timeout_seconds = 10
end
