module JiraCards
  module JiraApi
    class Issue
      def self.where(jira_query)
        criteria.where(jira_query)
      end

      def self.count
        criteria.count
      end

      private

      def self.criteria
        @criteria ||= Criteria.new(api_end_point)
      end

      def self.api_end_point
        JiraCards::Config.api + 'search/'
      end
    end

    class Criteria < Struct.new(:api_end_point)
      include Enumerable

      BATCH_SIZE = 50

      def where(jira_query)
        @query = (@query || '') + jira_query.to_s
        self
      end

      def each(&block)
        objects.each(&block)
      end

      def count
        batch(1)['total']
      end

      private

      def objects
        @objects ||= offsets.map { |offset| batch(offset)['issues'] }.flatten
      end

      def get(params: {})
        JSON.parse resource.get params: params.merge(jql: @query)
      end

      def batch(offset)
        get(params: { startAt: offset, maxResults: BATCH_SIZE })
      end

      def offsets
        (0..(count - 1)).step(BATCH_SIZE)
      end

      def resource
        @resource ||= RestClient::Resource.new(
          api_end_point, JiraCards::Config.user, JiraCards::Config.password)
      end
    end
  end
end
