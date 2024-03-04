require_relative '../lib/content_recommendation/type_recommendation'
require_relative '../lib/content_recommendation/entities/movie'
require_relative '../lib/content_recommendation/entities/book'

RSpec.describe TypeRecommendation do
  let(:movie1) { Movie.new({ creator: "Director1", title: "Movie1", year: "2001" }) }
  let(:movie2) { Movie.new({ creator: "Director2", title: "Movie2", year: "2002" }) }
  let(:movie3) { Movie.new({ creator: "Director1", title: "Movie3", year: "2003" }) }

  describe '#get_unique_creators' do
    it 'returns unique creators from the items' do
      expect(subject.get_unique_creators([movie1, movie2, movie3])).to eq(["Director1", "Director2"])
    end
  end

  describe '#get_all_items_by_creators' do
    it 'returns all items by a specific creator' do
      expect(subject.get_all_items_by_creators([movie1, movie2, movie3], "Director1")).to eq([movie1, movie3])
    end
  end
end
