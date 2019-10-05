class SellController < ApplicationController
  # 商品情報
  before_action :set_product, only: [:show]
  # カテゴリー
  before_action :set_category, only: [:show]
  # 商品状態
  before_action :set_condition, only: [:show]
  # 配送元地域
  before_action :set_prefecture, only: [:show]
  # 発送日目安、配送方法、配送料の負担
  before_action :set_delivery, only: [:show]
  # ユーザー情報
  before_action :set_user, only: [:show]
  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  private
  def product_params
    params.require(:product).permit( :name, :description, :category_id, :condition_id, :size_id, :brand, :delivery_charge_id, :delivery_way_id, :prefecture_id, :delivery_days_id, :price, images: []).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_category
    @smallcategory = Category.find(@product.category_id)
    @category = Category.find(Category.find(@product.category_id).sub_sub)
    @bigcategory = Category.find(Category.find(@product.category_id).sub)
  end

  def set_condition
    @condition = Condition.find(@product.condition_id)
  end

  def set_prefecture
    @prefecture = Prefecture.find(@product.prefecture_id)
  end

  def set_delivery
    @delivery_charge = DeliveryCharge.find(@product.delivery_charge_id)
    @delivery_way = DeliveryWay.find(@product.delivery_way_id)
    @delivery_days = DeliveryDays.find(@product.delivery_days_id)
  end

  def set_user
    @user = User.find(@product.user_id)
  end
end
