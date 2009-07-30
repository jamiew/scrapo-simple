#!/usr/bin/env ruby
# gets all the .torrent files from the btjunkie frontpage
# jamiew 12/8/07, http://jamiedubs.com

require 'rubygems'
require 'mechanize'

agent = WWW::Mechanize.new
url = "http://btjunkie.org/"
page = agent.get(url)

# extract links from the page that end with ".torrent"
hrefs = page.links.map { |m| m.href }.select { |u| u =~ /\.torrent$/ } # just links ending in .torrent

# again, make a place to put our files
FileUtils.mkdir_p('torrents')

# iterate through all the snagged links & save their files
# using mechanize's handy save_as() method
hrefs.each { |torrent|
  filename = "torrents/#{torrent.split('/')[-2]}.torrent"
  puts "Saving #{torrent} as #{filename}"
  agent.get(torrent).save_as(filename)
}
