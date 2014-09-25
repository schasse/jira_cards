module JiraCards
  class PdfCreator < Struct.new(:svgs)
    def create_pdf
      Prawn::Document.generate(JiraCards::Config.output) do |pdf|
        svgs.each do |svg|
          append_page pdf, svg
          pdf.start_new_page unless pdf.page_count == svgs.size
        end
      end
    end

    private

    def append_page(pdf, svg)
      pdf.svg(
        svg,
        at: [pdf.bounds.left, pdf.bounds.top],
        width: pdf.bounds.width)
    end
  end
end
