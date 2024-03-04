#!/usr/bin/env ruby

class Factory
  def self.create_from_content(type, content)
    content.flat_map do |creator, content|
      content.map do |item|
        type.new(creator: creator, title: item[:title], year: item[:year])
      end
    end
  end
end
