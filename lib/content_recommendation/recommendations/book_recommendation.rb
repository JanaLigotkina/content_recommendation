#!/usr/bin/env ruby

class BookRecommendation < TypeRecommendation
  FILE_NAME_PATH = 'books.xml'.freeze

  def xml_paths
    [
      BooksXmlPaths::BOOK_PATH,
      BooksXmlPaths::CREATOR_PATH,
      BooksXmlPaths::TITLE_PATH,
      BooksXmlPaths::YEAR_PATH
    ]
  end

  def create_from_content(book_content)
    Factory.create_from_content(Book, book_content)
  end
end
