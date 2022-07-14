class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_by_name(search)
    where("name ILIKE ?", "%#{search}%")
  end

  def self.find_by_min_price(search)
    where("unit_price >= ?", search).order('lower(name)')
  end

  def self.find_by_max_price(search)
    where("unit_price <= ?", search).order('lower(name)')
  end
end
