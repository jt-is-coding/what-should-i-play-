require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

giant_bomb_key = ENV.fetch("GIANT_BOMB_KEY")

get("/") do
  
  @user_year = null
  giant_bomb_url = "https://www.giantbomb.com/api/games/?api_key=#{giant_bomb_key}&format=json&filter=expected_release_year:#{@user_year}"

  erb(:main)

end
