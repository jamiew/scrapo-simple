#!/usr/bin/env ruby
# finds and saves MySpace top friends' thumbnails
# jamiew 12/8/07, http://jamiedubs.com

require 'rubygems'
require 'mechanize'

agent = WWW::Mechanize.new
url = "http://myspace.com/graffitiresearchlab"
page = agent.get(url)

# grab all of the <img> tags from the "friend area" -- found classname w/ Firebug
imgs = page.search('.friendSpace img')

# make the images directory
FileUtils.mkdir_p 'myspace-images'

# save each image to our images dir
imgs.each_with_index { |img, index| 
  url = img['src']
  puts "Saving thumbnail #{url}"
  agent.get(url).save_as("myspace-images/top_friend#{index}_#{File.basename url}")
}