require_relative '../lib/content_recommendation/parsers/xml_parser'
require 'rexml/document'

RSpec.describe XMLParser do
  let(:xml_parser) { XMLParser.new }
  let(:file) { double('File') }
  let(:creator_path) { 'creator' }
  let(:title_path) { 'title' }
  let(:year_path) { 'year' }

  before do
    allow(File).to receive(:open).and_yield(file)
  end

  describe '#parse' do
    context 'when parsing movies' do
      let(:element_path) { "movies/movie" }

      before do
        allow(file).to receive(:read).and_return('<movies><movie><title>Movie1</title><year>2001</year><creator>Director1</creator></movie><movie><title>Movie2</title><year>2001</year><creator>Director1</creator></movie></movies>')
      end

      it 'parses the XML file correctly' do
        result = xml_parser.parse('valid_file_path', element_path, creator_path, title_path, year_path)
        expect(result).to be_a(Hash)
        expect(result["Director1"]).to match_array([{ title: "Movie1", year: "2001" }, { title: "Movie2", year: "2001" }])
      end
    end

    context 'when parsing books' do
      let(:element_path) { "books/book" }

      before do
        allow(file).to receive(:read).and_return('<books><book><title>Book1</title><year>2001</year><creator>Author1</creator></book><book><title>Book2</title><year>2001</year><creator>Author1</creator></book></books>')
      end

      it 'parses the XML file correctly' do
        result = xml_parser.parse('valid_file_path', element_path, creator_path, title_path, year_path)
        expect(result).to be_a(Hash)
        expect(result["Author1"]).to match_array([{ title: "Book1", year: "2001" }, { title: "Book2", year: "2001" }])
      end
    end
  end
end
