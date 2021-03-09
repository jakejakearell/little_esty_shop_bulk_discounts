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
    (total_revenue_no_discount +  total_revenue_discount)
  end

  def total_revenue_no_discount
    merchants
    .joins(:discounts)
    .where("invoice_items.quantity < discounts.quantity_threshold")
    .select("invoice_items.item_id")
    .group(:item_id)
    .maximum(("(invoice_items.quantity * invoice_items.unit_price)"))
    .values
    .sum
  end

  def total_revenue_discount
    merchants
    .joins(:discounts)
    .where("discounts.quantity_threshold <= invoice_items.quantity")
    .select("invoice_items.item_id")
    .group(:item_id)
    .minimum(("(invoice_items.quantity * invoice_items.unit_price)* (1 - percentage_discount)"))
    .values
    .sum
  end
end
