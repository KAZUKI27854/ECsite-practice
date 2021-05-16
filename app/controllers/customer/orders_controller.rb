class Customer::OrdersController < ApplicationController
  include ApplicationHelper

  def new
    @order = Order.new
    current_customer = Customer.find(1)
    @my_postcode = current_customer.postcode
    @my_address = current_customer.address
    @deliveries = Delivery.where(customer_id: current_customer.id)

    #cart_item = current_customer.cart_item
    #if cart_item.empty?
       #redirect_to cart_items_path
    #end
  end

  def confirm
    current_customer = Customer.first
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order = Order.new(order_params)

    address = params[:order][:delivery_address]
    case address
    when "自宅"
      @order.delivery_postcode = current_customer.postcode
      @order.delivery_address = current_customer.address
      @order.delivery_name = customer_full_name(current_customer.id)
    when "登録済住所"
      delivery_id = params[:order][:delivery_address_id]
      delivery = Delivery.find_by(id: delivery_id)
      @order.delivery_postcode = delivery.postcode
      @order.delivery_address = delivery.address
      @order.delivery_name = delivery.name
    when "新しい届け先"
      @order.delivery_postcode = params[:order][:new_postcode]
      @order.delivery_address = params[:order][:new_address]
      @order.delivery_name = params[:order][:new_name]
    end
  end

  def create
    @order = Order.create(order_params)
    redirect_to order_complete_path
  end

  def complete
  end

  def show
  end

  private

  def order_params
   params.require(:order).permit(:customer_id, :postage, :total_price, :payment_method, :status,
                                 :delivery_name, :delivery_postcode, :delivery_address)
  end
end
