# Yopto appkey crawler
A ruby script to crawl for app keys on a list of domains 

Use the ```appkey_crawl.rb``` file in order to crwal for app keys for a list of accounts.

#How to use:
1. Clone the repo
2. ``` ruby appkey_crawl.rb [list of domains |or| link to .csv file] ```
3. Output would be saved to a file called "urls_and_appkeys.csv"

Example:
```ruby appkey_crawl.rb http://www.yotpo.com http://www.google.com```

**You must include http/https**
