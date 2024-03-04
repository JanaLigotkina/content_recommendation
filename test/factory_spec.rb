require_relative '../lib/content_recommendation/factories/factory'
require_relative '../lib/content_recommendation/entities/content'
require_relative '../lib/content_recommendation/entities/movie'
require_relative '../lib/content_recommendation/entities/book'
require 'rexml/document'

describe Factory do
  describe '.create_from_content' do
    types_and_contents = [
      { type: Movie, content: { 'Director' => [{ title: 'Title', year: 'Year' }] } },
      { type: Book, content: { 'Author' => [{ title: 'Book Title', year: 'Book Year' }] } }
    ]

    types_and_contents.each do |item|
      it "creates an array of #{item[:type]} objects from the content" do
        result = Factory.create_from_content(item[:type], item[:content])

        expect(result).to all(be_a(item[:type]))
        expect(result.first.title).to eq(item[:content].values.first.first[:title])
        expect(result.first.year).to eq(item[:content].values.first.first[:year])
      end
    end
  end
end
