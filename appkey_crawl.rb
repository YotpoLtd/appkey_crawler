require 'anemone'
app_keys = {}

if ARGV.empty?
  p "please pass some URLs to proccess"
  exit
end
urls = ARGV

print "working"
Anemone.crawl(urls) do |anemone|
  print "."
  anemone.focus_crawl do |page|

    anemone.focus_crawl { |page| page.links.slice(0..5) }

    if page.body.include?('.yotpo.com/')
      app_key = page.body.split('.yotpo.com/')[1].split('/widget.js')[0]
      app_keys[page.url] = app_key
    else
      app_keys[page.url] = "can't find yotpo appkey"
    end

    page.url

  end

end

puts "\n"

app_keys.each do |url, ak|
  puts "#{url}: #{ak}"
end



