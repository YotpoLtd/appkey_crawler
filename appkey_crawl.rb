require 'open-uri'
require 'open_uri_redirections'
require 'csv'

app_keys = {}

if ARGV.empty?
  p "please pass some URLs to proccess"
  exit
end
urls = ARGV


print "working"


urls.each do |url|
  print "."
  begin
    html = open(url,{ :allow_redirections => :safe, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36' }).read
  rescue
    app_keys[url] = "URL Error"
    next
  end

  if html.include?('.yotpo.com/')
    app_key = html.split('.yotpo.com/')[1].split('/widget.js')[0]
    app_keys[url] = app_key
  else
    app_keys[url] = "can't find yotpo appkey"
  end

end

puts "\n"

CSV.open("urls_and_appkeys.csv", "wb") do |csv|
  app_keys.each do |url, ak|
    csv << [url, ak]
    puts "#{url}: #{ak}"
  end
end




