require 'nokogiri'
require 'open-uri'

class Notice < ApplicationRecord
  url = "https://thenextweb.com/latest/"
  data = Nokogiri::HTML(open(url))
  @notices = data.css('h4_story-title a')
  @notices.each do |notice|
    Notice.create(
        :title => notice.css('story_title').text.strip,
        :link => notice.css('side').text.strip,
        :writer => notice.css('story-chunk').text.strip,
        :created_on => notice.css('side back').text.strip
    )
  end
end