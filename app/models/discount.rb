class Discount < ApplicationRecord
  validates :percentage_discount, presence: true
  validates :quantity_threshold, presence: true

  validates :percentage_discount, numericality: { less_than: 1 }
  validates :quantity_threshold, numericality: true

  belongs_to :merchant

  def percentage_discount_exists?
    !percentage_discount.nil?
  end

  def percentage_discount_greater_than_one?
    percentage_discount >= 1
  end
end
