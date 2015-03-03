module JiraCards
  Config = Struct.new(:argv) do
    include ActiveSupport::Configurable

    DEFAULT_CONFIG = File.expand_path 'default.yml', JiraCards::CONFIG_PATH
    HOME_CONFIG = File.expand_path '~/.jira_cards'
    LOCAL_CONFIG = File.expand_path '.jira_cards'

    AVAILABLE_OPTIONS = {
      domain: 'The jira domain.',
      user: 'Username for basic auth.',
      password: 'Password for basic auth.',
      query: 'A query defined in jql (jira query language).',
      output: 'Output file name.'
    }

    AVAILABLE_OPTIONS.keys.each do |config|
      config_accessor config
    end

    class << self
      def load(argv = nil)
        config = new argv
        AVAILABLE_OPTIONS.keys.each do |option|
          option_value = config.options[option]    ||
            config.local_config[option.to_s]       ||
            config.home_config[option.to_s]        ||
            ENV['JIRA_CARDS' + option.to_s.upcase] ||
            config.default_config[option.to_s]
          send "#{option}=", option_value
        end
      end

      def reset
        AVAILABLE_OPTIONS.keys.each do |option|
          send "#{option}=", nil
        end
      end
    end

    def default_config
      @defaule_config ||= YAML.load File.read DEFAULT_CONFIG
    end

    def home_config
      @home_config ||=
        (File.exist?(HOME_CONFIG) && YAML.load(File.read(HOME_CONFIG))) || {}
    end

    def local_config
      @local_config ||=
        (File.exist?(LOCAL_CONFIG) && YAML.load(File.read(LOCAL_CONFIG))) || {}
    end

    def options
      unless @options
        @options = {}
        option_parser.parse argv
      end
      @options
    end

    private

    def option_parser
      OptionParser.new do |opts|
        opts.banner = 'Usage: jira_cards [options]'

        AVAILABLE_OPTIONS.each do |option, description|
          add_option opts, option, description
        end

        opts.on_tail('--version', 'Show version.') do
          puts JiraCards::VERSION
          exit
        end
      end
    end

    def add_option(opts, option, description)
      opts.on(
        "-#{option.to_s.chars.first}",
        "--#{option} #{option.to_s.upcase}",
        description) do |option_value|
        @options[option] = option_value
      end
    end
  end
end
