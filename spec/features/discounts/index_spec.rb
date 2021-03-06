require 'rails_helper'

RSpec.describe 'As a Merchant', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Amazon')
    @merchant_2 = Merchant.create!(name: 'Mom and Pop')

    @discount_1 = @merchant_1.discounts.create!(quantity_threshold: 5, percentage_discount: 0.5 )
    @discount_2 = @merchant_1.discounts.create!(quantity_threshold: 10, percentage_discount: 0.6 )
    @discount_3 = @merchant_2.discounts.create!(quantity_threshold: 15, percentage_discount: 0.9 )

  end

  describe 'When i visit my discount index page' do
    it 'shows me all of my invoices and their percentage discount and quantity thresholds' do
      visit merchant_discounts_path(@merchant_1)

      expect(page).to have_content("Discount #{@discount_1.percentage_discount}")
      expect(page).to have_content("Items needed to purchase for discount: #{@discount_1.quantity_threshold}")

      expect(page).to have_content("Discount #{@discount_2.percentage_discount}")
      expect(page).to have_content("Items needed to purchase for discount: #{@discount_2.quantity_threshold}")

      expect(page).to have_no_content("Discount #{@discount_3.percentage_discount}")
      expect(page).to have_no_content("Items needed to purchase for discount: #{@discount_3.quantity_threshold}")
    end

    it 'next to each discount is a link taking me to its show page' do
      visit merchant_discounts_path(@merchant_1)

      expect(page).to have_link("Discount #{@discount_1.id} information")
      expect(page).to have_link("Discount #{@discount_2.id} information")

      click_link "Discount #{@discount_1.id} information"

      expect(current_path).to eq(merchant_discount_path(@merchant_1, @discount_1))

    end

    it 'shows the date and name of the next three holidays' do
      visit merchant_discounts_path(@merchant_1)

      expect(page).to have_content("Memorial Day")
      expect(page).to have_content("2021-05-31")

      expect(page).to have_content("Independence Day")
      expect(page).to have_content("2021-07-05")

      expect(page).to have_content("Labour Day")
      expect(page).to have_content("2021-09-06")

    end
  end
end
