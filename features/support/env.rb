#coding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'aruba/cucumber'
require 'gglog'
require 'tmpdir'

Before do
  GGLOG_HOME = Dir.mktmpdir
end
