class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = Array.new
  end

  def add_vendor(vendor_obj)
    @vendors << vendor_obj
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.find_all{|vendor| vendor.inventory.has_key?(item)}
  end

  def sorted_item_list
    @vendors.map {|vendor| vendor.inventory.keys}
    .flatten
    .uniq
    .sort
  end

  def total_inventory
    inventory_hash = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each { |item, quantity|
        inventory_hash[item] += quantity
      }
    end
    inventory_hash
  end

  def sell(item, quantity)
    return false if total_inventory[item] - quantity < 0
    org_quantity = quantity
    vendors_with_item = vendors_that_sell(item)
    vendors_with_item.each do |vendor|
      if total_inventory[item] == total_inventory[item] - org_quantity
        break
      elsif vendor.inventory[item] - quantity > 0
        vendor.inventory[item] -= quantity
      elsif vendor.inventory[item] - quantity < 0
        new_quantity = quantity - (quantity - vendor.inventory[item])
        quantity = quantity - new_quantity
        vendor.inventory[item] -= new_quantity
      end
    end
    true
  end
end
