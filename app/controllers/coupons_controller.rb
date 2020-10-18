class CouponsController < ApplicationController
  before_action :set_promotion_coupons, only: %i[index discard retrieve]

  def index; end

  def discard
    @coupon = Coupon.find(params[:id])
    @coupon.update!(status: :discarded, 
                    discard_user: current_user.social_name, 
                    discard_date: Date.current)
    render :index, notice: 'Cupom descartado'
  end

  def retrieve
    @coupon = Coupon.find(params[:id])
    @coupon.update!(status: :usable)
    render :index, notice: 'Cupom recuperado'
  end
  private

  def set_promotion_coupons
    @promotion = Promotion.find(params[:promotion_id])
    @coupons = @promotion.coupons
  end
end

