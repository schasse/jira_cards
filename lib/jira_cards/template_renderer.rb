module JiraCards
  module TemplateRenderer
    TEMPLATE_PATH = File.expand_path(
    '9_issues_for_dina4.svg', JiraCards::RESOURCES_PATH)
  end

  TemplateRenderer = Struct.new(:issues) do
    def rendered_templates
      issue_summaries.each_slice(9).map do |issue_summaries_slice|
        rendered_template issue_summaries_slice
      end.flatten
    end

    private

    def rendered_template(issue_summaries_slice)
      @issues =
        issue_summaries_slice +
        (9 - issue_summaries_slice.length).times.map { { summary: [] } }
      ERB.new(template_file_contents.clone).result binding
    end

    def issue_summaries
      issues.map do |issue|
        {
          key: CGI.escapeHTML(issue['key']),
          summary: aligned(issue['fields']['summary'])
        }
      end
    end

    def template_file_contents
      @template_file_contents ||= CGI.unescapeHTML File.read(
        TemplateRenderer::TEMPLATE_PATH)
    end

    def aligned(issue_summary)
      issue_summary.chars.each_slice(40).map do |summary_slice|
        CGI.escapeHTML(summary_slice.join)
      end
    end
  end
end
