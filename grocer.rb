def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0 
  result = nil
  while index < collection.length do 
    if(name == collection[index][:item])
      return collection[index]
    else
      result
    end
    index += 1
  end
  return result
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  consolidated = []
  index = 0 
  while index < cart.length do
    item_check = find_item_by_name_in_collection(cart[index][:item], consolidated)
    if(item_check)
      # this line matches the index of first instance of the item and iterates count if the item is already present in consolidated array
      consolidated[consolidated.index(item_check)][:count] += 1
    else
      consolidated << {:item => cart[index][:item], :price => cart[index][:price], :clearance => cart[index][:clearance], :count => 1}
    end
      
    index += 1
  end
return consolidated
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons_index = 0 
  while coupons_index < coupons.length do
    cart_index = 0
    while cart_index < cart.length do
            if(cart[cart_index][:item] == coupons[coupons_index][:item] && cart[cart_index][:count] >= coupons[coupons_index][:num])
              cart[cart_index][:count] -= coupons[coupons_index][:num]
              cart << {:item => "#{cart[cart_index][:item]} W/COUPON", :price => (coupons[coupons_index][:cost] / coupons[coupons_index][:num]), :clearance => cart[cart_index][:clearance], :count => coupons[coupons_index][:num]}
            end
      cart_index += 1
    end
    coupons_index += 1
  end
  return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0 
  while index < cart.length do
    if(cart[index][:clearance])
      cart[index][:price] -= cart[index][:price] * 0.2
      cart[index][:price].round(2)
    end
    index += 1
  end
  return cart
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
  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)
  total = 0 
  index = 0
  while index < applied_clearance.length do
    total += (applied_clearance[index][:count] * applied_clearance[index][:price])
    index += 1
  end
  if(total > 100)
    total = total - (0.1 * total)
  end
  return total
end
