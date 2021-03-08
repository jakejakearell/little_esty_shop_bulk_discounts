require 'rails_helper'

RSpec.describe 'As a Merchant', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')
    @merchant_2 = Merchant.create!(name: 'Mom and Pop')

    @discount_1 = @merchant_1.discounts.create!(quantity_threshold: 5, percentage_discount: 0.5 )
    @discount_2 = @merchant_1.discounts.create!(quantity_threshold: 10, percentage_discount: 0.6 )
    @discount_3 = @merchant_2.discounts.create!(quantity_threshold: 15, percentage_discount: 0.9 )

  end

  describe 'When i visit a discount edit page' do
    it 'I see a form prepopulated with the discounts information' do
      visit edit_merchant_discount_path(@merchant_1, @discount_1)

      click_button

      expect(current_path).to eq(merchant_discounts_path(@merchant_1))

      expect(page).to have_content("5")
      expect(page).to have_content("50")
    end

    it 'I can edit information and am sent back to merchant index ' do
      visit edit_merchant_discount_path(@merchant_1, @discount_1)

      fill_in 'Quantity threshold', with: 212
      fill_in 'Percentage discount', with: 0.8787

      click_button

      expect(current_path).to eq(merchant_discounts_path(@merchant_1))

      expect(page).to have_content("212")
      expect(page).to have_content("8787")
    end

    it 'I am warned if my data type is invalid and kept on the edit page' do
      visit edit_merchant_discount_path(@merchant_1, @discount_1)

      fill_in 'Quantity threshold', with: "Grogs"
      fill_in 'Percentage discount', with: 0.8787

      click_button

      expect(current_path).to eq(edit_merchant_discount_path(@merchant_1, @discount_1))

      expect(page).to have_content("Discount not created: Required information missing or invalid.")
    end

    it 'I am warned if my percentage discount is too high and kept on the edit page' do
      visit edit_merchant_discount_path(@merchant_1, @discount_1)

      fill_in 'Quantity threshold', with: 50
      fill_in 'Percentage discount', with: 1.8787

      click_button

      expect(current_path).to eq(edit_merchant_discount_path(@merchant_1, @discount_1))

      expect(page).to have_content("Discount not created: Percent discount must be entered as a decimal.")
    end
  end
end
