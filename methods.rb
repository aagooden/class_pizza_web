final_order = {}


def current_order_total(current_order)
#puts "Hitting the method... current_order is #{current_order}"
  total = 0

  if current_order[0][0] == "small"
      total = total + 10
    elsif current_order[0][0] == "medium"
      total = total + 15
    elsif current_order[0][0] == "large"
      total = total + 20
  end


  if current_order[3][0] == nil
  else
    total = total + ((current_order[3][0].length - 1) * 2)
  end

  if current_order[4][0] == nil
  else
    total = total + ((current_order[4][0].length - 1) * 1)
  end


  return total
end


def overall_total(full_order)
  total = 0
  full_order.each do |order|
    total += order[5]
  end
  puts "Hitting the method.  The total is #{total}"
  return total
end

def premade_pizza(value)
  @size.push("medium")
  @crust.push("regular")
  if value.join == "ham"
    @sauce.push("spicy")
  else
    @sauce.push("tomato")
  end
  @meats.push(value)
  @toppings.push(["cheese"])
end
