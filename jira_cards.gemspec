$LOAD_PATH.unshift 'lib'
require 'jira_cards/version'

Gem::Specification.new do |s|
  s.name         = 'jira_cards'
  s.version      = JiraCards::VERSION
  s.date         = Time.now.strftime('%Y-%m-%d')
  s.summary      = 'With JiraCards you can print Jira issues in a pdf.'
  s.homepage     = 'http://github.com/schasse/jira_cards'
  s.email        = 'sebastian.schasse@gapfish.com'
  s.authors      = ['schasse']
  s.has_rdoc     = false
  s.licenses     = ['MIT']

  s.description  = <<desc
  Feed me.
desc

  s.files        = Dir['{bin,lib,resources,config}/**/*']
  s.files       += %w(README.md MIT-LICENSE)
  s.test_files   = Dir['spec/**/*']

  s.executables  = %w( jira_cards )

  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'restclient'
  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'prawn-svg'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-its'
  s.add_development_dependency 'travis'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'cane'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'appraisal'
end
