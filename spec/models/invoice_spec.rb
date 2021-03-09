require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    # @discount_1 = @merchant1.discounts.create!(quantity_threshold: 5, percentage_discount: 0.5 )
    # @discount_2 = @merchant1.discounts.create!(quantity_threshold: 9, percentage_discount: 0.6 )

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
    @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)
  end

  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end

  describe "instance methods" do
    describe "::total_revenue_with_no_discount" do
      it 'returns total revenue of items that have no discounts applied' do
        expect(@invoice_1.total_revenue_no_discount).to eq(10)
      end
    end

    describe "::total_revenue_with_no_discount" do
      it 'returns total revenue of items that have no discounts applied' do
        expect(@invoice_1.total_revenue_discount).to eq(36)

      end
    end

    describe "::total_revenue" do
      it 'returns total revenue of all items regardless of disocunt status' do
        expect(@invoice_1.total_revenue).to eq(46)
      end
    end
  end
end
