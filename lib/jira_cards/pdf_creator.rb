module JiraCards
  class PdfCreator < Struct.new(:svgs)
    def create_pdf
      Prawn::Document.generate('jira_issues.pdf') do |pdf|
        svgs.each do |svg|
          pdf.svg(
            svg,
            at: [pdf.bounds.left, pdf.bounds.top],
            width: pdf.bounds.width)
          pdf.start_new_page unless pdf.page_count == svgs.size
        end
      end
    end
  end
end
