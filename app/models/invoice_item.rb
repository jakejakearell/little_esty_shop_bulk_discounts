class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item

  enum status: [:pending, :packaged, :shipped]

  def discount_applied(quantity, unit_price)
    item
    .merchant
    .discounts
    .where("quantity_threshold <= #{quantity}")
    .select("(#{quantity} * #{unit_price})* (1 - percentage_discount) as discount, discounts.id")
    .order(:discount)
    .first
    
  end

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end
end
