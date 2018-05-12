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

  def total
    discounted_line_item_total = line_item_total + discount_on_line_item_total

    discounted_order_total = (discounted_line_item_total + discount_total_on_order_total(discounted_line_item_total)).round(2)

    "£#{discounted_order_total}"
  end



  private

  def line_item_promotions
    li_promos = []

    @promotions.each do |promo|
      li_promos << promo if promo.adjustment_type == PromotionBase::LINE_ITEM_ADJUSTMENT
    end

    li_promos
  end

  def order_total_promotions
    ot_promos = []

    @promotions.each do |promo|
      ot_promos << promo if promo.adjustment_type == PromotionBase::ORDER_TOTAL_ADJUSTMENT
    end

    ot_promos
  end

  def line_item_total
    amount = 0

    @scanned_items.each do |item|
      amount += item.price
    end

    amount
  end

  # if there is a discount it will be a negative number
  def discount_on_line_item_total
    total_discount = 0

    line_item_promotions.each do |promotion|
      total_discount += discount_for_line_item_promotion(promotion)
    end

    total_discount
  end

  def discount_for_line_item_promotion(promotion)
    discount_per_item = promotion.adjustment_amount({scanned_items: @scanned_items})
    no_of_promotion_items_scanned = scanned_item_count_for_code(promotion.product_code)

    discount_per_item * no_of_promotion_items_scanned
  end

  def discount_total_on_order_total(line_item_total_after_discount)
    total_discount = 0
      order_total_promotions.each do |promotion|
        total_discount += promotion.adjustment_amount({line_item_total: line_item_total_after_discount})
      end

    total_discount
  end


  def scanned_item_count_for_code(product_code)
    count = 0

    @scanned_items.each do |item|
      count += 1 if item.code == product_code
    end

    count
  end


end
