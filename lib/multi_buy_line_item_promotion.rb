require 'promotion_base'

class MultiBuyLineItemPromotion < PromotionBase

  attr_reader :no_items_required_to_qualify
  attr_reader :discount_per_item

  def initialize(no_items_required_to_qualify, discount_per_item)
    @no_items_required_to_qualify = no_items_required_to_qualify
    @discount_per_item = discount_per_item

    raise(ArgumentError, 'no_items_required_to_qualify must greater than zero') if no_items_required_to_qualify <= 0
  end

  def adjustment_type
    ProductBase::LINE_ITEM_ADJUSTMENT
  end

  def qualifies_for_promotion?(opts = {})
    raise NotImplementedError, 'sub class must implement qualifies_for_promotion? method'
  end

  def adjustment_amount(opts = {})
    raise NotImplementedError, 'sub class must implement adjustment_amount method'
  end

end
