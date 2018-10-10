require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  #find where downcased input matches downcased character in [results][index]
  result = response_hash["results"].find { |n| n["name"].downcase == character.downcase }
  #set films urls from that index to a variable
  film_result = result["films"]
  #parse those urls for JSON and collect the titles
  film_info = film_result.collect {|i| JSON.parse(RestClient.get(i))}
  #return the titles
  film_info
end

#iterate over hash and put titles with index
def parse_character_movies(films_hash)
  films_hash.each.with_index(1) do |data, index| 
  puts "#{index} " + data['title'] 
  end
end

#return titles and pass to parse as arg method
def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  parse_character_movies(films_array)
end

