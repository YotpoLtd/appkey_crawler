require 'open-uri'
require 'open_uri_redirections'

app_keys = {}

if ARGV.empty?
  p "please pass some URLs to proccess"
  exit
end
urls = ARGV


print "working"


urls.each do |url|
  print "."
  html = open(url,{ :allow_redirections => :safe, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36' }).read
  if html.include?('.yotpo.com/')
    app_key = html.split('.yotpo.com/')[1].split('/widget.js')[0]
    app_keys[url] = app_key
  else
    app_keys[url] = "can't find yotpo appkey"
  end
end

puts "\n"

app_keys.each do |url, ak|
  puts "#{url}: #{ak}"
end



