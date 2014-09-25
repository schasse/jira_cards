require 'spec_helper'

describe JiraCards::TemplateRenderer do
  let(:renderer) { JiraCards::TemplateRenderer.new issues }
  let(:issues) do
    [
      {
        'key' => key,
        'fields' => { 'summary' => summary }
      }
    ]
  end
  let(:key) { 'T-123' }
  let(:summary) { 'Do not Look.' }

  describe '#rendered_templates' do
    let(:rendered_templates) { renderer.rendered_templates }

    it 'returns an Array of Strings' do
      expect(rendered_templates).to be_a Array
      rendered_templates.each { |template| expect(template).to be_a String }
    end

    its 'result contains the key and summary' do
      expect(rendered_templates.to_s).to include key
      expect(rendered_templates.to_s).to include summary
    end
  end
end
