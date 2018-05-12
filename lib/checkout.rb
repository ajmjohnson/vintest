class Checkout

  attr_reader :scanned_items
  attr_reader :promotions

  def initialize(promotions = [])
    @scanned_items = []
    @promotions = promotions
  end

  def scan(item)
    raise ArgumentError, 'Scanned item is not a Product' unless item.is_a?(Product)
    @scanned_items << item
  end

end
