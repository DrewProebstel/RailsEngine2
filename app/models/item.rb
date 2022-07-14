class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_by_name(search)
    where("LOWER(name) LIKE ?", "%#{search.downcase}%").first
  end
end
