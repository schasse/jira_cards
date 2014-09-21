module JiraCards
  class Config
    class << self
      def query
        ENV['QUERY']
      end

      def user
        ENV['USER']
      end

      def password
        ENV['PASSWORD']
      end

      def api
        'https://gapfish.atlassian.net/rest/api/2/'
      end
    end
  end
end
