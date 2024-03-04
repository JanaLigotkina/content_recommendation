#!/usr/bin/env ruby

class XMLParser
  def parse(file_path, element_path, creator_path, title_path, year_path)
    File.open(file_path, 'r:UTF-8') do |file|
      data = REXML::Document.new(file.read)
      parse_content(data, element_path, creator_path, title_path, year_path)
    end
  end

  private

  def parse_content(data, element_path, creator_path, title_path, year_path)
    data_hash = {}

    data.elements.each(element_path) do |item|
      creator = item.elements[creator_path].text
      title = item.elements[title_path].text
      year = item.elements[year_path].text

      data_hash[creator] = [] unless data_hash.key?(creator)
      data_hash[creator] << { title: title, year: year }
    end

    data_hash
  end
end
