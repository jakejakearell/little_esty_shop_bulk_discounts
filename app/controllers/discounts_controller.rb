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
    @discount = Discount.find(params[:id])
  end

  def update
    discount = Discount.find(params[:id])
    discount.update({
                    quantity_threshold: params[:discount][:quantity_threshold],
                    percentage_discount: params[:discount][:percentage_discount]
                    })
    if discount.save
      redirect_to merchant_discounts_path(params[:merchant_id])
    elsif discount.percentage_discount_exists? && discount.percentage_discount_greater_than_one?
      flash[:notice] = "Discount not created: Percent discount must be entered as a decimal."
      redirect_to edit_merchant_discount_path(params[:merchant_id], params[:id])
    else
      flash[:notice] = "Discount not created: Required information missing or invalid."
      redirect_to edit_merchant_discount_path(params[:merchant_id], params[:id])
    end
  end

  def destroy
    Discount.destroy(params[:id])

    redirect_to merchant_discounts_path(params[:merchant_id])
  end

  private

  def discount_params
    params.permit(:quantity_threshold, :percentage_discount, :merchant_id)
  end
end
