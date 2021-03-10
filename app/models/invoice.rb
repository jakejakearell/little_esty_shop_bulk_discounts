class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  enum status: [:cancelled, :in_progress, :complete]

  def total_revenue
    if number_of_discounts_invoice_is_eligible_for == 0
      total_revenue_no_discounts
    else
      (total_revenue_of_items_with_no_discounts +  total_revenue_of_items_with_discounts)
    end
  end

  def number_of_discounts_invoice_is_eligible_for
    merchants
    .joins(:discounts)
    .where("invoice_items.quantity >= discounts.quantity_threshold")
    .count
  end

  def total_revenue_of_items_with_no_discounts
    merchants
    .joins(:discounts)
    .where("invoice_items.quantity < discounts.quantity_threshold")
    .select("invoice_items.item_id")
    .group(:item_id)
    .maximum(("(invoice_items.quantity * invoice_items.unit_price)"))
    .pluck(1)
    .sum
  end

  def total_revenue_of_items_with_discounts
    merchants
    .joins(:discounts)
    .where("discounts.quantity_threshold <= invoice_items.quantity")
    .select("invoice_items.item_id")
    .group(:item_id)
    .minimum(("(invoice_items.quantity * invoice_items.unit_price)* (1 - percentage_discount)"))
    .pluck(1)
    .sum
  end

  def total_revenue_no_discounts
    invoice_items.sum("unit_price * quantity")
  end
end
