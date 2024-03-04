#!/usr/bin/env ruby

class Content
  attr_reader :creator, :title, :year

  def initialize(data)
    @creator = data[:creator]
    @title = data[:title]
    @year = data[:year]
  end

  def to_s
    "`#{title}` by #{creator} (#{year} year)"
  end
end
