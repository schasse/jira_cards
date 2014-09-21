require 'spec_helper'

describe JiraCards::Runner do
  describe '.invoke' do
    let(:runner) { JiraCards::Runner }
    let(:generated_pdf) do
      File.expand_path '../../../jira_issues.pdf', __FILE__
    end

    before do
      allow(JiraCards::Config).to receive(:user).and_return nil
      allow(JiraCards::Config).to receive(:password).and_return nil
      allow(JiraCards::Config).to receive(:query).and_return 'key = WBS-181'
      allow(JiraCards::Config).to receive(:api)
        .and_return 'https://jira.atlassian.com/rest/api/2/'
      runner.invoke
    end
    after { File.delete generated_pdf }

    it 'creates a pdf file' do
      expect(File).to exist(generated_pdf)
    end
  end
end
