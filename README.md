jira_cards
=========
[![Build Status](https://travis-ci.org/schasse/jira_cards.svg?branch=master)](https://travis-ci.org/schasse/jira_cards)
[![Coverage Status](https://coveralls.io/repos/schasse/jira_cards/badge.png)](https://coveralls.io/r/schasse/jira_cards)
[![Dependency Status](https://gemnasium.com/schasse/jira_cards.svg)](https://gemnasium.com/schasse/jira_cards)
[![Code Climate](https://codeclimate.com/repos/5422d3166956803fb801aab7/badges/65b5d28c23f35ea81d75/gpa.svg)](https://codeclimate.com/repos/5422d3166956803fb801aab7/feed)

## Installation
The recommended way of installing jira_cards is via RubyGems:
`gem install jira_cards`

## Configuration
You can configure jira_cards with a config file located in the current folder of execution or your home directory:
```
# ~/.jira_cards
user: john
password: top_secret
```
```
# ./.jira_cards
domain: jira.atlassian.com
```

Alternatively you can control the configuration with the following environment variables:
```
JIRA_CARDS_DOMAIN
JIRA_CARDS_USER
JIRA_CARDS_PASSWORD
JIRA_CARDS_QUERY
JIRA_CARDS_OUTPUT
```

## examples
`jira_cards --query 'key = P-123' --output output.pdf`
`DOMAIN=jira.atlassian.com QUERY='project = P jira_cards`

For all available options use `jira_cards --help`.
