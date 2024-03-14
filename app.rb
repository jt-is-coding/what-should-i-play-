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
  if user_year.to_i > 2023 || user_year.to_i < 1972
    user_year = rand(1972..2023)
  end
  giant_bomb_url1 = "https://www.giantbomb.com/api/games/?api_key=#{giant_bomb_key}&format=json&field_list=name,deck,image,platforms&filter=expected_release_year:#{user_year}"
  raw_response = HTTP.get(giant_bomb_url1)
  @parsed_response = JSON.parse(raw_response)
  max_number = @parsed_response.fetch("number_of_total_results")
  max_offset = max_number.to_i - 100
  if max_number > 100
    giant_bomb_url2 = "https://www.giantbomb.com/api/games/?api_key=#{giant_bomb_key}&format=json&field_list=name,deck,image,platforms&offset=#{rand(100..max_offset)}&filter=expected_release_year:#{user_year}"
    raw_response = HTTP.get(giant_bomb_url2)
    @parsed_response = JSON.parse(raw_response)
    @offset = @parsed_response.fetch("offset")
    @results = @parsed_response.fetch("results")
    @results.each do |number|
      @game_list.push(number)
    end
  else
    @results = @parsed_response.fetch("results")
    @results.each do |number|
      @game_list.push(number)
    end
  end

  
  erb(:search)

end

get("/search/:year") do

  @game_list = []
  user_year = params.fetch("year")
  if user_year.to_i > 2023 || user_year.to_i < 1972
    user_year = rand(1972..2023)
  end
  giant_bomb_url1 = "https://www.giantbomb.com/api/games/?api_key=#{giant_bomb_key}&format=json&field_list=name,deck,image,platforms&filter=expected_release_year:#{user_year}"
  raw_response = HTTP.get(giant_bomb_url1)
  @parsed_response = JSON.parse(raw_response)
  max_number = @parsed_response.fetch("number_of_total_results")
  if max_number > 100
    giant_bomb_url2 = "https://www.giantbomb.com/api/games/?api_key=#{giant_bomb_key}&format=json&field_list=name,deck,image,platforms&offset=#{rand(100..max_number)}&filter=expected_release_year:#{user_year}"
    raw_response = HTTP.get(giant_bomb_url2)
    @parsed_response = JSON.parse(raw_response)
    @results = @parsed_response.fetch("results")
    @results.each do |number|
      @game_list.push(number)
    end
  else
    @results = @parsed_response.fetch("results")
    @results.each do |number|
      @game_list.push(number)
    end
  end

  
  erb(:search)

end
