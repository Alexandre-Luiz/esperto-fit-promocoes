class PromotionsController < ApplicationController
  before_action :authorize_admin, only: %i[new create]
  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to @promotion, notice: 'Promoção cadastrada com sucesso!'
    else
      render :new
    end
  end

  private

  def promotion_params
    params.require(:promotion)
          .permit(:name, :description, :discount_rate, :expire_date, :coupon_quantity)
  end

  def authorize_admin
    redirect_to root_path, notice: 'Você não tem permissão para essa ação' unless current_user.admin?
  end
end