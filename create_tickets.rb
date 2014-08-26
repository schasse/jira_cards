#!/usr/bin/env ruby

require 'pry'
require 'json'
require 'restclient'
require 'cgi'

# TODO: devide into use_cases: JiraApi, TemplateCreator, PdfCreator, PdfIssuesWithTemplate

JIRA_API = 'gapfish.atlassian.net/rest/api/latest/search'
SEARCH = 'project = EC AND issuetype = Story AND status = Backlog'
BATCH_SIZE = 50

def append_issue_summaries
  @issue_summaries ||= []
  offsets.each do |offset|
    batch(offset)['issues'].each do |issue|
      @issue_summaries << issue_summary_from(issue)
    end
  end
end

def create_all_printable_issues
  pdfs = @issue_summaries
    .each_slice(9)
    .each_with_index
    .map do |issue_summaries_slice, index|

    template_file = create_template issue_summaries_slice, index
    make_pdf_from_template_file template_file
  end
  concat_pdfs pdfs
end

def create_template(issue_summaries, index)
  template = template_file_contents.clone
  template_file = "/tmp/jira_issue_template.tmp.#{index}.svg"
  issue_summaries.each_with_index do |issue_summary, issue_index|
    template.sub! "$ticket_nr_0#{issue_index}", issue_summary.first
    template.sub! "$ticket_txt_0#{issue_index}", issue_summary.last
  end
  File.open(template_file, 'w') { |f| f.write template }
  template_file
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

def issue_summary_from(issue)
  [
    CGI.escapeHTML(issue['key']),
    CGI.escapeHTML(issue['fields']['summary'])
  ]
end

def template_file_contents
  @template_file_contents ||= File.read 'dina4_6_template.svg'
end

# TODO: lookup ruby's copy
def copy(object)
  Marshal.load Marshal.dump(object)
end

# JIRA API
def get(params: {})
  search_string = CGI.escape(ARGV[1] || SEARCH_STRING)
  url = "https://#{ARGV.first}@" + JIRA_API + '?jql=' +
    ([search_string] + params.map { |key, value| "#{key}=#{value}" }).join('&')
  response_string = RestClient.get(url)
  JSON.parse response_string
end

def total_count
  # get['total']
  batch(1)['total']
end

def batch(offset)
  get(params: { startAt: offset, maxResults: BATCH_SIZE })
  # @batch ||= JSON.parse(File.read 'tickets_example.json')
end

def offsets
  (0..(total_count - 1)).step(BATCH_SIZE)
end

append_issue_summaries
create_all_printable_issues
