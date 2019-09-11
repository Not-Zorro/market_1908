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
end
