module ApplicationHelper

  def current_customer
    Customer.find(1)
  end

  def customer_full_name(customer_id)
    customer = Customer.find_by(id: customer_id)
    customer.last_name + customer.first_name
  end

  def tax_price(item_id)
    tax = 0.1
    market_price = Item.find_by(id: item_id).price
    ( market_price * (1 + tax) ).floor
  end

  def sub_price(cart_item_id)
    cart_item = CartItem.find_by(id: cart_item_id)
    tax_price(cart_item.item_id) * cart_item.quantity
  end

  def cart_items_total_price(customer_id)
    price = 0
    cart_items = CartItem.where(customer_id: customer_id)
    cart_items.each do |cart_item|
      price  +=  sub_price(cart_item.id)
    end
    return price
  end

  def billing(customer_id, order_id)
    order = Order.find_by(id: order_id)
    cart_items_total_price(customer_id) + order.postage
  end


end
