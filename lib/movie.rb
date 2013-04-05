module Movie
	def find_movie(search)
    imdb = ImdbParty::Imdb.new(anonymize: true)
		begin
			results = imdb.find_by_title(search);
			thing = results[0]
			id = thing.fetch(:imdb_id)
			movie = imdb.find_movie_by_id(id)

			message = ""

			message << "#{movie.title}"
			message << "\n"
			message << "Runtime: #{movie.runtime}"
			message << "\n"
			message << "Released #{movie.release_date.slice(0..3)}"
			message << "\n"
			message << "#{movie.certification}   "
			message << "\n"
			message << "Genres: #{movie.genres.at(0)} #{movie.genres.at(1)}"
			message << "\n"
			message << "Starring #{movie.actors.at(0).name} and #{movie.actors.at(1).name}"
		rescue
			message = "Error: Something went wrong"
		end # begin
		message
	end # def
end # module

# The League of Extraordinary Gentlemen
# Runtime: 110 min
# Released 2003
# PG-13
# Genres: Action Adventure
# Starring Sean Connery and Stuart Townsend
