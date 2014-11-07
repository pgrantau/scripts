#!/usr/bin/env ruby


require 'xmlrpc/client'
require 'fileutils'

list = []
channel = []

#Establish connection to Satellite
rhn = XMLRPC::Client.new([ipaddress], "/rpc/api", 80)
session_id = rhn.call "auth.login", [username], [password]

#List all cfgchannels in satellite
channels = rhn.call("configchannel.listGlobals", session_id)


channels.each do |l|
  #List files in channel
  FileUtils.mkdir l['label']

  channel_files = rhn.call("configchannel.listFiles", session_id, l['label'])
  channel = l['label']

  channel_files.each do |file|
    list << file['path']
    file_details = rhn.call("configchannel.lookupFileInfo", session_id, channel, list)
    file_details.each do |d|
      path = d['path']
      path = path.split('/')
      path = path.last
      contents = d['contents']
    File.open("#{channel}/#{path}", 'w') {|f| f.write("#{contents}") }
    list = []
  end


end
end
