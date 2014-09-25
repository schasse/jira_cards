require 'spec_helper'

describe JiraCards::Runner do
  describe '.invoke' do
    let(:runner) { JiraCards::Runner }
    let(:generated_pdf) do
      File.expand_path '../../../jira_issues.pdf', __FILE__
    end

    before do
      JiraCards::Config.query = 'key = WBS-24'
      JiraCards::Config.domain = 'jira.atlassian.com'
      runner.invoke
    end
    after { File.delete generated_pdf }

    it 'creates a pdf file' do
      expect(File).to exist(generated_pdf)
    end
  end
end
