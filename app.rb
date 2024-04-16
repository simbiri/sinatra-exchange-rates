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
  cur_quotes_url = "#{base_url}live?access_key=#{access_key}" +\
  "&source=#{@cur_currency}"
  quotes_resp = HTTP.get(cur_quotes_url)
  @quotes = JSON.parse(quotes_resp)["quotes"]

  erb(:quotes)  
end

get("/:cur_org/:cur_dest")do

  @cur_org = params.fetch("cur_org")
  @cur_dest = params.fetch("cur_dest")

  convert_url = "#{base_url}convert?access_key=#{access_key}" +\
  "&from=#{@cur_org}&to=#{@cur_dest}&amount=1"
  convert_resp = HTTP.get(convert_url)
  @result = JSON.parse(convert_resp)["result"]

  erb(:conversion)  
end
