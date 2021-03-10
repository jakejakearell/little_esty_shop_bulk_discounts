require 'rails_helper'

RSpec.describe 'welcome page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'What a nice store')
  end
  
  it 'shows link to the merchant dashboards' do
    visit '/'
    expect(page).to have_link "#{@merchant1.name}", href:merchant_dashboard_index_path(@merchant1)
    expect(page).to have_link "#{@merchant2.name}", href:merchant_dashboard_index_path(@merchant2)
  end

  it 'shows link to the admin dashboards' do
    visit '/'
    expect(page).to have_link "Admin Dashboard", href:admin_dashboard_index_path
  end
end
