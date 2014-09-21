# TODO: devide into use_cases: PdfCreator, PdfIssuesWithTemplate
module JiraCards
  class Runner
    class << self
      def invoke
        rendered_templates = TemplateRenderer
          .new(JiraApi::Issue.where(JiraCards::Config.query))
          .rendered_templates
        create_all_printable_issues rendered_templates
      end

      private

      def create_all_printable_issues(rendered_templates)
        pdfs = rendered_templates.map do |rendered_template|
          make_pdf_from_template_file rendered_template
        end
        concat_pdfs pdfs
      end

      def make_pdf_from_template_file(template_file)
        pdf_file = template_file.sub 'svg', 'pdf'
        `inkscape --file=#{template_file} --export-pdf=#{pdf_file}`
        `rm #{template_file}`
        pdf_file
      end

      def concat_pdfs(pdfs)
        `pdftk #{pdfs.join(' ')} cat output jira_issues.pdf`
        pdfs.each { |pdf| `rm #{pdf}` }
      end
    end
  end
end
