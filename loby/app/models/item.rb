class Item < ApplicationRecord
  before_destroy :delete_file
  after_save :delete_file
  belongs_to :user

  def delete_file
    old_path = image_path_was
    return unless old_path.to_s.starts_with?('/uploads')

    filepath = Rails.root.join('public', old_path[1..-1])
    FileUtils.rm(filepath)
  end
end
