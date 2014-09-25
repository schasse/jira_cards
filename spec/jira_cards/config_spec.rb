require 'spec_helper'

describe JiraCards::Config do
  subject { JiraCards::Config }

  context 'with default config' do
    before { JiraCards::Config.load }
    its(:user) { should eq ENV['USER'] }
    its(:domain) { should eq 'jira.atlassian.com' }
    its(:query) { should eq nil }
  end

  context 'with local config' do
    let(:local_config) { JiraCards::Config::LOCAL_CONFIG }

    before do
      File.open(local_config, 'w') { |f| f.write 'password: top_secret' }
      JiraCards::Config.load
    end
    after { File.delete local_config }

    its(:password) { should eq 'top_secret' }
  end

  context 'with options' do
    let(:argv) { ['-q', 'key = WIB-123'] }
    before { JiraCards::Config.load argv }
    its(:query) { should eq 'key = WIB-123' }
  end
end
