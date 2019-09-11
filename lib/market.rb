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
    @vendors.group_by do |vendor|
      vendor.inventory.each { |item, quantity|
        inventory_hash[item] += quantity
      }
    end
    inventory_hash
  end
end
