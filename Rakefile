# frozen_string_literal: true

require 'rake/testtask'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'test/*spec.rb'
end

task default: :spec
