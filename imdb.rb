require 'rubygems'
require 'shoulda'
gem 'httparty', '=0.8.2'
require 'httparty'
require 'imdb_party'

 @imdb = ImdbParty::Imdb.new
 @movie = @imdb.find_movie_by_id("tt0382932")

puts @movie.title
puts @movie.rating
puts @movie.certification
