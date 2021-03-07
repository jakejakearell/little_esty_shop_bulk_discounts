require 'rails_helper'

RSpec.describe 'As a Merchant', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')
    @merchant_2 = Merchant.create!(name: 'Mom and Pop')

    @discount_1 = @merchant_1.discounts.create!(quantity_threshold: 5, percentage_discount: 0.5 )
    @discount_2 = @merchant_1.discounts.create!(quantity_threshold: 10, percentage_discount: 0.6 )
    @discount_3 = @merchant_2.discounts.create!(quantity_threshold: 15, percentage_discount: 0.9 )

  end

  describe 'When i visit a discount show page' do
    it 'I see its percentage discount and quantity thresholds' do
      visit merchant_discount_path(@merchant_1, @discount_1)

      expect(page).to have_content(@discount_1.quantity_threshold)
      expect(page).to have_content(@discount_1.percentage_discount)

      expect(page).to have_no_content(@discount_2.quantity_threshold)
      expect(page).to have_no_content(@discount_2.percentage_discount)

      expect(page).to have_no_content(@discount_3.quantity_threshold)
      expect(page).to have_no_content(@discount_3.percentage_discount)
    end

    it 'I see a link to edit the discount that takes me to a new edit page' do
      visit merchant_discount_path(@merchant_1, @discount_1)

      expect(page).to have_link("Edit Discount")

      click_link "Edit Discount"

      expect(current_path).to eq(edit_merchant_discount(@discount_1))

    end
  end
end
