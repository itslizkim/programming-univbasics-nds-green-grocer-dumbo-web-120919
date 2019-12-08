def find_item_by_name_in_collection(name, collection)
  i = 0

  while i < collection.length do
    return collection[i] if name === collection[i][:item]
    i += 1
  end

  nil
end

def consolidate_cart(cart)
  i = 0
  result = []

  while i < cart.count do
    item_name = cart[i][:item]
    collect_item = find_item_by_name_in_collection(item_name,result)
    if collect_item
      collect_item[:count] += 1
    else
      cart[i][:count] = 1
      result << cart[i]
    end
    i += 1
  end
  result

end

def coupon_price(c)
  round_price = (c[:cost].to_f * 1.0 / c[:num]).round(2)
  {
    :item => "#{c[:item]} W/COUPON",
    :price => round_price,
    :count => c[:num]
  }
end

def apply_coup_to_cart(match_item, coupon, cart)
  match_item[:count] -= coupon[:num]
  item_w_coup = coupon_price(coupon)
  item_w_coup[:clearance] = match_item[:clearance]
  cart << item_w_coup
end

def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.count do
    coupon = coupons[i]
    items_w_coupon = find_item_by_name_in_collection(coupon[:item],cart)
    item_in_cart = !!items_w_coupon
    coupon_applied_cart = item_in_cart && items_w_coupon[:count] >= coupon[:num]

    if item_in_cart and coupon_applied_cart
      apply_coup_to_cart(items_w_coupon,coupon,cart)
    end
    i+=1
  end

  cart
end

def apply_clearance(cart)
  i = 0
  while 1 < cart.length do
    item = cart[i]
    if item[:clearance]
      discounted_price = ((1 - CLEARANCE_ITEM_DISCOUNT_RATE) * item[:price]).round(2)
        item[:price] = discounted_price
    end
    i +=1
  end

  cart

    # Consult README for inputs and outputs


  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
