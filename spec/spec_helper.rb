$LOAD_PATH.unshift File.expand_path '../../lib', __FILE__

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
