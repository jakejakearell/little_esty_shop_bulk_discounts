class DiscountsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    @merchant_discounts = merchant.merchant_discounts
  end

  def show
    @discount = Discount.find(params[:id])
  end
end
