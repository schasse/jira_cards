module JiraCards
  class Config
    include ActiveSupport::Configurable

    DEFAULT_CONFIG = File.expand_path 'config/default.yml', JiraCards::PATH
    HOME_CONFIG = File.expand_path '~/.jira_cards'
    LOCAL_CONFIG = File.expand_path '.jira_cards'

    AVAILABLE_CONFIGS = [
      :domain,
      :user,
      :password,
      :query
    ]

    AVAILABLE_CONFIGS.each do |config|
      config_accessor config
    end

    class << self
      def default_config
        YAML.load File.read DEFAULT_CONFIG
      end

      def home_config
        (File.exist?(HOME_CONFIG) && YAML.load(File.read(HOME_CONFIG))) || {}
      end

      def local_config
        (File.exist?(LOCAL_CONFIG) && YAML.load(File.read(LOCAL_CONFIG))) || {}
      end

      def load
        AVAILABLE_CONFIGS.each do |config|
          config_value = local_config[config.to_s] ||
            home_config[config.to_s]               ||
            ENV[config.to_s.upcase]                ||
            default_config[config.to_s]
          send "#{config}=", config_value
        end
      end
    end
  end
end