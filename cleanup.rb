#!/usr/bin/env ruby

require 'fileutils'
revisions = 2
applications = [
      'application1',
      'application2'
    ]

env = ['dev','uat','prod']
applications.each do |app|
env.each do |env|
  all_files = Dir.glob("/var/www/html/#{env}/#{app}*")
  files_keep = all_files.last(revisions)
    all_files.each do |file|
      FileUtils.remove("#{file}") unless files_keep.include?(file) || "specificapp"
    end
  end
end
