module JiraCards
  class Runner
    class << self
      def invoke
        create_pdf_from rendered_templates_from jira_issues
      end

      private

      def create_pdf_from(templates)
        PdfCreator.new(templates).create_pdf
      end

      def rendered_templates_from(jira_issues)
        TemplateRenderer.new(jira_issues).rendered_templates
      end

      def jira_issues
        JiraApi::Issue.where JiraCards::Config.query
      end
    end
  end
end
