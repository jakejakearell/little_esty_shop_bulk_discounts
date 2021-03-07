class DiscountsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    @merchant_discounts = merchant.merchant_discounts
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
  end

  def create
    discount = Discount.new(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(params[:merchant_id])
    elsif discount.percentage_discount_exists? && discount.percentage_discount_greater_than_one?
      flash[:notice] = "Discount not created: Percent discount must be entered as a decimal."
      render :new
    else
      flash[:notice] = "Discount not created: Required information missing or invalid."
      render :new
    end
  end

  def edit

  end 

  private

  def discount_params
    params.permit(:quantity_threshold, :percentage_discount, :merchant_id)
  end
end
