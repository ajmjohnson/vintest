require 'promotion_base'

class OrderTotalPromotion < PromotionBase

  attr_reader :discount_percentage
  attr_reader :min_total_to_qualify

  def initialize(min_total_to_qualify, discount_percentage)
    @min_total_to_qualify = min_total_to_qualify
    @discount_percentage = discount_percentage
  end

  def adjustment_type
    ORDER_TOTAL_ADJUSTMENT
  end

  def qualifies_for_promotion?(opts = {})
    raise ArgumentError, 'line_item_total must be passed as an argument' if opts.key?("line_item_total")

    if opts[:line_item_total] >= min_total_to_qualify
      true
    else
      false
    end
  end

  def adjustment_amount(opts = {})
    raise ArgumentError, 'line_item_total must be passed as an argument' if opts.key?("line_item_total")

    if qualifies_for_promotion?(opts)
      - opts[:line_item_total] / @discount_percentage
    else
      0.0
    end
  end

end
