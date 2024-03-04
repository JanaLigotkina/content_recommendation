#!/usr/bin/env ruby

class MovieRecommendation < TypeRecommendation
  FILE_NAME_PATH = 'movies.xml'.freeze

  def xml_paths
    [
      MoviesXmlPaths::MOVIE_PATH,
      MoviesXmlPaths::CREATOR_PATH,
      MoviesXmlPaths::TITLE_PATH,
      MoviesXmlPaths::YEAR_PATH
    ]
  end

  def create_from_content(movie_content)
    Factory.create_from_content(Movie, movie_content)
  end
end
