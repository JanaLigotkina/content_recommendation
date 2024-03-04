require_relative '../lib/content_recommendation/entities/content'
require_relative '../lib/content_recommendation/entities/movie'
require_relative '../lib/content_recommendation/entities/book'
require 'rexml/document'

RSpec.describe 'Content subclasses' do
  types_and_contents = [
    { type: Movie, creator: "Director1", title: "Movie1", year: "2001", to_s: "`Movie1` by Director1 (2001 year)" },
    { type: Book, creator: "Author1", title: "Book1", year: "2001", to_s: "`Book1` by Author1 (2001 year)" }
  ]

  types_and_contents.each do |item|
    context "#{item[:type]} class" do
      let(:content_data) { { creator: item[:creator], title: item[:title], year: item[:year] } }
      let(:content) { item[:type].new(content_data) }

      describe '#initialize' do
        it 'initializes with correct data' do
          expect(content.creator).to eq(item[:creator])
          expect(content.title).to eq(item[:title])
          expect(content.year).to eq(item[:year])
        end
      end

      describe '#to_s' do
        it 'returns a string representation of the content' do
          expect(content.to_s).to eq(item[:to_s])
        end
      end
    end
  end
end
