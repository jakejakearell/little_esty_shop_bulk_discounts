require 'rails_helper'

RSpec.describe 'As a Merchant', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')
    @merchant_2 = Merchant.create!(name: 'Mom and Pop')

    @discount_1 = @merchant_1.discounts.create!(quantity_threshold: 5, percentage_discount: 0.5 )
    @discount_2 = @merchant_1.discounts.create!(quantity_threshold: 10, percentage_discount: 0.6 )
    @discount_3 = @merchant_2.discounts.create!(quantity_threshold: 15, percentage_discount: 0.9 )

  end

  describe 'When i visit a discount create page' do
    it 'I can fill in a form with discount info and when I submit I am taken to my discount index page where I see my new discount' do
      visit new_merchant_discount_path(@merchant_1)

      expect(page).to have_content('Create Merchant Discount')
      fill_in 'Quantity threshold', with: 212
      fill_in 'Percentage discount', with: 0.8787

      click_button

      expect(current_path).to eq(merchant_discounts_path(@merchant_1))

      expect(page).to have_content("212")
      expect(page).to have_content("8787")
    end

    it 'If I leave information incomplete I see a warning message and my discount is not created' do
      visit new_merchant_discount_path(@merchant_1)

      expect(page).to have_content('Create Merchant Discount')

      click_button

      expect(page).to have_content("Discount not created: Required information missing or invalid.")
    end

    it 'If use the wrong datatype I see a warning message and my discount is not created' do
      visit new_merchant_discount_path(@merchant_1)

      expect(page).to have_content('Create Merchant Discount')

      fill_in 'Quantity threshold', with: "i like turtles"
      fill_in 'Percentage discount', with: "wow what a cool worl"

      click_button

      expect(page).to have_content("Discount not created: Required information missing or invalid.")

    end

    it 'If enter the percentage discount as something over 1 I get an error' do
      visit new_merchant_discount_path(@merchant_1)

      expect(page).to have_content('Create Merchant Discount')

      fill_in 'Quantity threshold', with: 122
      fill_in 'Percentage discount', with: 1.8787

      click_button

      expect(page).to have_content("Discount not created: Percent discount must be entered as a decimal.")

    end
  end
end
