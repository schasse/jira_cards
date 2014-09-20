class JiraApi
  API = 'https://gapfish.atlassian.net/rest/api/2/'

  class Issue
    END_POINT = API + 'search/'

    def self.where(jira_query)
      criteria.where(jira_query)
    end

    def self.count
      criteria.count
    end

    private

      def self.criteria
        @criteria ||= Criteria.new(END_POINT)
      end
  end

  class Criteria < Struct.new(:api_end_point)
    BATCH_SIZE = 50

    def where(jira_query)
      @query = (@query || '') + jira_query
      self
    end

    # or each
    def to_a
      @objects ||= offsets.map do |offset|
        batch(offset)['issues']
      end.flatten
    end

    def count
      batch(1)['total']
    end

    private

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
        @resource ||= RestClient::Resource
          .new api_end_point, ENV['USER'], ENV['PASSWORD']
      end
  end
end
