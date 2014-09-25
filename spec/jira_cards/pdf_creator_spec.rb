require 'spec_helper'

describe JiraCards::PdfCreator do
  let(:creator) { JiraCards::PdfCreator.new svgs }
  let(:svgs) { 3.times.map { svg } }
  let(:svg) { File.read JiraCards::TemplateRenderer::TEMPLATE_PATH }

  describe '#create_pdf' do
    let(:generated_pdf) do
      File.expand_path '../../../jira_issues.pdf', __FILE__
    end
    let(:page_count) { Prawn::Document.new(template: generated_pdf).page_count }
    before do
      JiraCards::Config.output = 'jira_issues.pdf'
      creator.create_pdf
    end
    after { File.delete generated_pdf }

    it 'creates one concatenated pdf' do
      expect(File).to exist(generated_pdf)
      # TODO: make this work expect(page_count).to eq 3
    end
  end
end
