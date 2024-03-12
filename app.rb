require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

giant_bomb_key = ENV.fetch("GIANT_BOMB_KEY")

get("/") do
  
  erb(:main)

end

get("/search") do

  @game_list = []
  user_year = params.fetch("year")
  giant_bomb_url = "https://www.giantbomb.com/api/games/?api_key=#{giant_bomb_key}&format=json&field_list=name,deck&filter=expected_release_year:#{user_year}"
  raw_response = HTTP.get(giant_bomb_url)
  @parsed_response = JSON.parse(raw_response)
  @results = @parsed_response.fetch("results")
  @results.each do |number|
    @game_list.push(number)
  end

  
  erb(:search)

end

get("/search/:year") do

  @game_list = []
  user_year = params.fetch("year")
  giant_bomb_url = "https://www.giantbomb.com/api/games/?api_key=#{giant_bomb_key}&format=json&field_list=name,deck&filter=expected_release_year:#{user_year}"
  raw_response = HTTP.get(giant_bomb_url)
  @parsed_response = JSON.parse(raw_response)
  @results = @parsed_response.fetch("results")
  @results.each do |number|
    @game_list.push(number)
  end

  
  erb(:search)

end
