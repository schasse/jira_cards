path_to_lib = File.expand_path '../../lib', __FILE__
$LOAD_PATH.unshift path_to_lib

require 'rspec/its'
require 'pry'
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

require 'jira_cards'

RSpec.configure do |config|
  config.order = 'random'
end
