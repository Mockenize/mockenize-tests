require 'cucumber'
require 'cucumber/rake/task'
require "httparty"

task default: :features

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty"
end
