class PromotionBase

  LINE_ITEM_ADJUSTMENT = 'LINE_ITEM_ADJUSTMENT'
  ORDER_TOTAL_ADJUSTMENT = 'ORDER_TOTAL_ADJUSTMENT'

  def adjustment_type
    raise NotImplementedError, 'sub class must implement adjustment_type method'
  end

  def qualifies_for_promotion?(opts = {})
    raise NotImplementedError, 'sub class must implement qualifies_for_promotion? method'
  end

  def adjustment_amount(opts = {})
    raise NotImplementedError, 'sub class must implement adjustment_amount method'
  end
end
