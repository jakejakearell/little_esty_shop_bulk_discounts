require 'rails_helper'

RSpec.describe Discount, type: :model do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')
    @merchant_2 = Merchant.create!(name: 'Mom and Pop')

    @discount_1 = @merchant_1.discounts.create!(quantity_threshold: 5, percentage_discount: 0.5 )
    @discount_2 = @merchant_1.discounts.create!(quantity_threshold: 10, percentage_discount: 0.6 )
    @discount_3 = @merchant_2.discounts.create!(quantity_threshold: 15, percentage_discount: 0.9 )
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "validations" do
    it { should validate_presence_of :percentage_discount }
    it { should validate_presence_of :quantity_threshold }

    it { should validate_numericality_of :percentage_discount }
    it { should validate_numericality_of :quantity_threshold }
  end

  describe "instance methods" do
   describe "::percentage_discount_exists?" do
     it 'checks to see if user did not enter a percentage_discount' do
       expect(@discount_1.percentage_discount_exists?).to eq(true)
     end
   end

   describe "::percentage_discount_greater_than_one?" do
     it 'checks to see if user entered a percentage_discount greater than one' do
       expect(@discount_1.percentage_discount_greater_than_one?).to eq(false)
     end
   end
 end
end
