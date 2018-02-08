require 'open-uri'
require 'open_uri_redirections'
require 'csv'
require 'typhoeus'

app_keys = {}
IN_PARALLEL = 20

if ARGV.empty?
  p "please pass some URLs to proccess or a CSV file"
  exit
end
if ARGV.length == 1 && ARGV[0].include?(".csv")
  urls = CSV.read(ARGV[0])
else
  urls = ARGV
end

urls.each_slice(IN_PARALLEL) do |slice_urls|
  p "working on #{IN_PARALLEL} requests in parallel"
  hydra = Typhoeus::Hydra.new
  requests = []

  slice_urls.each do |url|
    if url.is_a?(Array)
      url = url[0]
    end
    request = Typhoeus::Request.new(url, followlocation: true)
    hydra.queue(request)
    requests << [url,request]

  end
  
  hydra.run
  requests.each do |url,resopnse|
    html = resopnse.response.body
    if html.include?('.yotpo.com/')
      app_key = html.split('.yotpo.com/')[1].split('/widget.js')[0]
      app_keys[url] = app_key
    else
      app_keys[url] = "can't find yotpo appkey"
    end
    puts "#{url}: #{app_key}"
  end



end

puts "\n"

CSV.open("urls_and_appkeys.csv", "wb") do |csv|
  app_keys.each do |url, ak|
    csv << [url, ak]
  end
end


