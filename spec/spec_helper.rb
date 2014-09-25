path_to_lib = File.expand_path '../../lib', __FILE__
$LOAD_PATH.unshift path_to_lib

require 'rspec/its'
require 'pry'
unless ENV['APPRAISAL_INITIALIZED']
  require 'coveralls'
  Coveralls.wear!
end

require 'jira_cards'

RSpec.configure do |config|
  config.order = 'random'

  config.before(:each) do
    JiraCards::Config.reset
  end
end
