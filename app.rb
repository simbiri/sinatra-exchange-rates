require "sinatra"
require "sinatra/reloader"
require  "http"

base_url = "https://api.exchangerate.host/"
access_key = ENV["EXCHANGE_RATE_KEY"]

get("/") do

  cur_pairs_url = "#{base_url}list?access_key=#{access_key}"
  cur_resp = HTTP.get(cur_pairs_url)
  @currencies = JSON.parse(cur_resp)["currencies"]

  erb(:currency_pairs)
end

get("/:currency")do
  @cur_currency = params.fetch("currency")
  cur_quotes_url = "#{base_url}live?access_key=#{access_key}"
  
end
