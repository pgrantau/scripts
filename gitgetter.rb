#!/usr/bin/env ruby

require 'json'

org = [organisation]
token = [access_token]

github_url = "https://api.github.com/orgs/#{org}/repos?access_token=#{token}"

names = []
(1..6).each do |page|
  response = `curl -sS '#{github_url}&page=#{page}'`

  parsed_response = JSON.parse(response)

  parsed_response.each do |repo_data|
    repo << repo_data['ssh_url']
  end
end

repo.each do |ssh_url|
  %x[ git clone #{ssh_url} ]
end
