#encoding:utf-8
require "open-uri"
def curl(url)
  url.each do |_url|
    puts open(_url).read
  end
end
