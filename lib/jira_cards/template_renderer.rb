module JiraCards
  class TemplateRenderer < Struct.new(:issues)
    TEMPLATE_PATH = File.expand_path(
      'dina4_6_template.svg', JiraCards::RESOURCES_PATH)

    def rendered_templates
      issue_summaries.each_slice(9).map do |issue_summaries_slice|
        rendered_template issue_summaries_slice
      end.flatten
    end

    private

    def rendered_template(issue_summaries_slice)
      template = template_file_contents.clone
      issue_summaries_slice.each_with_index.map do |issue_summary, issue_index|
        template.sub! "$ticket_nr_0#{issue_index}", issue_summary.first
        template.sub! "$ticket_txt_0#{issue_index}", issue_summary.last
      end
    end

    def issue_summaries
      issues.map do |issue|
        [
          CGI.escapeHTML(issue['key']),
          CGI.escapeHTML(issue['fields']['summary'])
        ]
      end
    end

    def template_file_contents
      @template_file_contents ||= File.read TEMPLATE_PATH
    end
  end
end
