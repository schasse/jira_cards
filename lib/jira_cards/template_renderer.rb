module JiraCards
  class TemplateRenderer < Struct.new(:issues)
    def rendered_templates
      issue_summaries
        .each_slice(9)
        .each_with_index
        .map do |issue_summaries_slice, index|

        create_template issue_summaries_slice, index
      end
    end

    private

    def create_template(issue_summaries_slice, index)
      template = template_file_contents.clone
      template_file = "/tmp/jira_issue_template.tmp.#{index}.svg"
      issue_summaries_slice.each_with_index do |issue_summary, issue_index|
        template.sub! "$ticket_nr_0#{issue_index}", issue_summary.first
        template.sub! "$ticket_txt_0#{issue_index}", issue_summary.last
      end
      File.open(template_file, 'w') { |f| f.write template }
      template_file
    end

    def issue_summaries
      issues.map do |issue|
        issue_summary_from(issue)
      end
    end

    def issue_summary_from(issue)
      [
        CGI.escapeHTML(issue['key']),
        CGI.escapeHTML(issue['fields']['summary'])
      ]
    end

    def template_file_contents
      @template_file_contents ||= File.read(File.join(File.dirname(File
              .expand_path(__FILE__)), '../../resources/dina4_6_template.svg'))
    end
  end
end
