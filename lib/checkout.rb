class Checkout

  attr_reader :scanned_items
  attr_reader :promotions

  def initialize(promotions = [])
    @scanned_items = []
    @promotions = promotions
  end

end
