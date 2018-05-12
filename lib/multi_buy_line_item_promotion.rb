require 'promotion_base'

class MultiBuyLineItemPromotion < PromotionBase

  attr_reader :product_code
  attr_reader :no_items_required_to_qualify
  attr_reader :discount_per_item

  def initialize(product_code, no_items_required_to_qualify, discount_per_item)
    @product_code = product_code
    @no_items_required_to_qualify = no_items_required_to_qualify
    @discount_per_item = discount_per_item

    raise(ArgumentError, 'no_items_required_to_qualify must greater than zero') if no_items_required_to_qualify <= 0
  end

  def adjustment_type
    LINE_ITEM_ADJUSTMENT
  end

  def qualifies_for_promotion?(opts = {})
    raise ArgumentError, 'scanned_items must be passed as an argument' if opts.key?("scanned_items")

    qualifying_items_count = 0

    opts[:scanned_items].each do |item|
      qualifying_items_count += 1 if item.code == @product_code
    end

    if qualifying_items_count >= @no_items_required_to_qualify
      true
    else
      false
    end
  end

  def adjustment_amount(opts = {})
    if qualifies_for_promotion?(opts)
      @discount_per_item
    else
      0.0
    end
  end

end
