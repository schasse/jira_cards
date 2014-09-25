module JiraCards
  class TemplateRenderer < Struct.new(:issues)
    TEMPLATE_PATH = File.expand_path(
      'dina4_6_template.svg', JiraCards::RESOURCES_PATH)

    def rendered_templates
      r = issue_summaries.each_slice(9).map do |issue_summaries_slice|
        rendered_template issue_summaries_slice
      end.flatten
      binding.pry
      r
    end

    private

    def rendered_template(issue_summaries_slice)
      @issues = issue_summaries_slice +
        (9 - issue_summaries_slice.length).times.map { {} }
      ERB.new(template_file_contents.clone).result binding
    end

    def issue_summaries
      issues.map do |issue|
        {
          key: CGI.escapeHTML(issue['key']),
          summary: CGI.escapeHTML(issue['fields']['summary'])
        }
      end
    end

    def template_file_contents
      @template_file_contents ||= CGI.unescapeHTML File.read TEMPLATE_PATH
    end
  end
end
