#!/usr/bin/env ruby

class TypeRecommendation
  FOLDER_PATH = 'data'.freeze

  def file_path
    File.expand_path(File.join(__dir__, FOLDER_PATH, self.class::FILE_NAME_PATH), __dir__)
  end

  def xml_paths
    raise NotImplementedError
  end

  def create_from_content(content)
    raise NotImplementedError
  end

  def get_unique_creators(items)
    @unique_creators ||= items.map { |item| item.creator }.uniq
  end

  def get_all_items_by_creators(data, creator)
    data.select { |item| item.creator == creator }
  end
end
