require 'nokogiri'
require 'open-uri'

class Notice < ApplicationRecord
  url = "https://thenextweb.com/"
  data = Nokogiri::HTML(open(url))
  @notices = data.css('h4.story-title a')
  @notices.each do |notice|
    Notice.create(
        :title => notice.css('h1').text.strip,
        :link => notice.css('side').text.strip,
        :writer => notice.css('div.post-body').text.strip,
        :created_on => Date.today.to_s
    )
  end
end