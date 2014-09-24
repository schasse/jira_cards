module JiraCards
  class PdfCreator < Struct.new(:svgs)
    def create_pdf
      pdfs = svg_files.map do |svg|
        make_pdf_from_template_file svg
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

    def svg_files
      svgs.each_with_index.map do |svg, index|
        template_file = "/tmp/jira_issue_template.tmp.#{index}.svg"
        File.open(template_file, 'w') { |f| f.write svg }
        template_file
      end
    end
  end
end
