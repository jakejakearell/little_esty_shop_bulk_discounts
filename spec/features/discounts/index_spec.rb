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

      within "#next_three_holidays" do
        expect(page.all('.holidays')[0]).to have_content("Memorial Day")
        expect(page.all('.holidays')[0]).to have_content("2021-05-31")

        expect(page.all('.holidays')[1]).to have_content("Independence Day")
        expect(page.all('.holidays')[1]).to have_content("2021-07-05")

        expect(page.all('.holidays')[2]).to have_content("Labour Day")
        expect(page.all('.holidays')[2]).to have_content("2021-09-06")
      end
    end

    it 'I see a link to create a new discount that takes me to a new page' do
      visit merchant_discounts_path(@merchant_1)

      expect(page).to have_link("New Discount")

      click_link "New Discount"

      expect(current_path).to eq(new_merchant_discount_path(@merchant_1))

    end

    it 'next to every discount I see a link to delete the discount' do
      visit merchant_discounts_path(@merchant_1)

      expect(page).to have_button("Discount #{@discount_1.id} delete")
      expect(page).to have_button("Discount #{@discount_2.id} delete")

    end

    it 'when I click on a delete link I am taken back to the index page where I do not see that item anymore ' do
      visit merchant_discounts_path(@merchant_1)

      expect(page).to have_content("Discount #{@discount_1.percentage_discount}")

      click_button ("Discount #{@discount_1.id} delete")
      expect(current_path).to eq(merchant_discounts_path(@merchant_1))
      expect(page).to have_no_content("Discount #{@discount_1.percentage_discount}")
    end

    it 'has a link to take me back to my dashboard' do
      visit merchant_discounts_path(@merchant_1)

      click_link "My Dashboard"

      expect(current_path).to eq(merchant_dashboard_index_path(@merchant_1))
    end
  end
end
