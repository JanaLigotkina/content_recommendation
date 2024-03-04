#!/usr/bin/env ruby

require_relative 'content_recommendation/paths/movies_xml_paths'
require_relative 'content_recommendation/paths/books_xml_paths'
require_relative 'content_recommendation/type_recommendation'
require_relative 'content_recommendation/recommendations/movie_recommendation'
require_relative 'content_recommendation/recommendations/book_recommendation'
require_relative 'content_recommendation/parsers/xml_parser'
require_relative 'content_recommendation/factories/factory'
require_relative 'content_recommendation/entities/content'
require_relative 'content_recommendation/entities/movie'
require_relative 'content_recommendation/entities/book'

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  ruby '>= 3.0.0'

  gem 'rainbow'
  gem 'rexml'
  gem 'rspec'
  gem 'thor'
end

class RecommendationCLI < Thor
  INVALID_TYPE_MSG = "Invalid type of recommendation".freeze
  INVALID_CHOICE_MSG = "Invalid choice. Please choose a number between 0 and %s.".freeze
  RECOMMENDATION_MSG = "\nToday, I recommend: %s".freeze

  desc 'recommend TYPE', 'Process a category of recommendation'
  method_option :type, default: 'movies'

  def recommend(type_of_recommendation = options[:type])
    type_recommendation = get_type_recommendation(type_of_recommendation)
    return unless type_recommendation

    file_path = type_recommendation.file_path
    parse_content = XMLParser.new.parse(file_path, *type_recommendation.xml_paths)
    items = type_recommendation.create_from_content(parse_content)
    unique_creators = type_recommendation.get_unique_creators(items)
    user_choice_creator = -> { get_user_choice(unique_creators) }

    show_creators(unique_creators)
    show_recommendation(type_recommendation, items, user_choice_creator)
  end

  private

  def get_type_recommendation(type)
    recommendation_classes = {
      'movies' => MovieRecommendation,
      'books' => BookRecommendation
    }

    recommendation_class = recommendation_classes[type]

    if recommendation_class
      recommendation_class.new
    else
      say Rainbow(INVALID_TYPE_MSG).red
      nil
    end
  end

  def show_creators(data)
    say Rainbow("Which creator's work would you like to see today?\n").green

    data.each_with_index do |creator, index|
      say Rainbow("#{index}. #{creator}").yellow
    end
  end

  def get_user_choice(data)
    loop do
      user_choice = STDIN.gets.chomp.to_i
      max_choice = data.size - 1

      return data[user_choice] if user_choice.between?(0, max_choice)

      say Rainbow(INVALID_CHOICE_MSG % max_choice).red
    end
  end

  def show_recommendation(type_recommendation, data, user_choice)
    creator_items = type_recommendation.get_all_items_by_creators(data, user_choice.call)
    recommended_item = creator_items.sample

    say Rainbow(RECOMMENDATION_MSG % recommended_item.to_s).green
  end
end
