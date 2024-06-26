# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"
require "json"

url = "https://tmdb.lewagon.com/movie/top_rated"
poster_base_url = "https://image.tmdb.org/t/p/w500/"
response_serialized = URI.open(url).read
response = JSON.parse(response_serialized)

response["results"].each do |movie|
  Movie.create(title: movie["title"], overview: movie["overview"], poster_url: "#{poster_base_url}#{movie["poster_path"]}" , rating: movie["vote_average"])
end

List.create(name: "Drama")
List.create(name: "All time favourites")
List.create(name: "Girl Power")
List.create(name: "Boy Power")
List.create(name: "Never watch again")

Bookmark.create(comment: "saw it at the cinema", list_id: List.first.id, movie_id: Movie.first.id)
Bookmark.create(comment: "saw it at the cinema", list_id: List.last.id, movie_id: Movie.first.id)
Bookmark.create(comment: "saw it at the cinema", list_id: List.first.id, movie_id: Movie.last.id)
