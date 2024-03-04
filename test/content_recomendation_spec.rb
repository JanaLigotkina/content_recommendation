require_relative '../lib/content_recommendation'
require_relative '../lib/content_recommendation/recommendations/movie_recommendation'
require_relative '../lib/content_recommendation/recommendations/book_recommendation'
require_relative '../lib/content_recommendation/entities/content'
require_relative '../lib/content_recommendation/entities/movie'
require_relative '../lib/content_recommendation/entities/book'
require_relative '../lib/content_recommendation/parsers/xml_parser'

describe RecommendationCLI do
  let(:cli) { RecommendationCLI.new }
  let(:movies) { [instance_double(Movie, creator: 'Director 1'), instance_double(Movie, creator: 'Director 2')] }
  let(:books) { [instance_double(Book, creator: 'Author 1'), instance_double(Book, creator: 'Author 2')] }
  let(:file_content) { "file_content" }
  let(:xml_parser) { instance_double(XMLParser) }
  let(:movie_recommendation) { instance_double(MovieRecommendation,
                                               file_path: 'movies.xml',
                                               xml_paths: ['path1', 'path2', 'path3', 'path4'],
                                               get_unique_creators: ['Director 1', 'Director 2'])
  }
  let(:book_recommendation) { instance_double(BookRecommendation,
                                              file_path: 'books.xml',
                                              xml_paths: ['path1', 'path2', 'path3', 'path4'],
                                              get_unique_creators: ['Author 1', 'Author 2'])
  }

  before do
    allow(XMLParser).to receive(:new).and_return(xml_parser)
    allow(xml_parser).to receive(:parse).and_return(file_content)
    allow(MovieRecommendation).to receive(:new).and_return(movie_recommendation)
    allow(BookRecommendation).to receive(:new).and_return(book_recommendation)
    allow(movie_recommendation).to receive(:create_from_content).and_return(movies)
    allow(book_recommendation).to receive(:create_from_content).and_return(books)
  end

  describe '#recommend' do
    context 'when type is movie' do
      it 'calls the necessary methods with the correct arguments' do
        expect(MovieRecommendation).to receive(:new)
        expect(movie_recommendation).to receive(:create_from_content).with(file_content)
        expect(cli).to receive(:show_creators).with(anything)
        expect(cli).to receive(:show_recommendation).with(movie_recommendation, movies, anything)

        cli.recommend('movies')
      end
    end

    context 'when type is book' do
      it 'calls the necessary methods with the correct arguments' do
        expect(BookRecommendation).to receive(:new)
        expect(book_recommendation).to receive(:create_from_content).with(file_content)
        expect(cli).to receive(:show_creators).with(anything)
        expect(cli).to receive(:show_recommendation).with(book_recommendation, books, anything)

        cli.recommend('books')
      end
    end

    it 'displays the correct output' do
      allow(cli).to receive(:show_creators) { puts 'Directors name output' }
      allow(cli).to receive(:show_recommendation) { puts 'Recommendation output' }
      expect { cli.recommend('movies') }.to output(/Directors name output/).to_stdout
      expect { cli.recommend('movies') }.to output(/Recommendation output/).to_stdout
    end

    context 'when handling user input' do
      let(:creators) { ['Director 1', 'Director 2'] }

      before do
        allow(cli).to receive(:get_unique_creators).and_return(creators)
      end

      it 'returns the correct creator when user input is valid' do
        allow(STDIN).to receive(:gets).and_return('0')
        expect(cli.send(:get_user_choice, creators)).to eq(creators[0])
      end
    end
  end
end
