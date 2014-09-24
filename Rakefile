#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :spec

require 'rubocop/rake_task'
RuboCop::RakeTask.new :rubocop

require 'cane/rake_task'
Cane::RakeTask.new :cane do |cane|
  cane.no_doc = true
end

require 'appraisal/task'
Appraisal::Task.new

task default: :appraisal if !ENV['APPRAISAL_INITIALIZED'] && !ENV['TRAVIS']
task default: [:rubocop, :cane, :spec]
