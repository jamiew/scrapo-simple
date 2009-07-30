#!/usr/bin/env ruby
# finds and saves all thumbnails from youtube top lists
# jamiew 12/8/07, http://jamiedubs.com

require 'rubygems'
require 'mechanize'
require 'hpricot'

agent = WWW::Mechanize.new
url = "http://gdata.youtube.com/feeds/api/standardfeeds/most_viewed" # all time
page = agent.get(url)

# parse again w/ Hpcricot for some XML convenience -- not efficient, but that's fine
doc = Hpricot.parse(page.body)

# pp (doc/:entry) # like "search"; cool division overload
images = (doc/'media:thumbnail') # use strings instead of symbols for namespaces

# make a place to dump images
FileUtils.mkdir_p 'youtube-images'

# iterate through & save all the images
urls = images.map { |i| i[:url] }
urls.each_with_index do |file,index|
  puts "Saving image #{file}"
  agent.get(file).save_as("youtube-images/vid#{index}_#{File.basename file}")
end
