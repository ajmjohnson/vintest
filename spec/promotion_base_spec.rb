require 'promotion_base'

describe PromotionBase do

  before do
    @promo = PromotionBase.new
  end

  describe "#adjustment_type" do
    it "should raise not implemented exception" do
      expect{@promo.adjustment_type}.to raise_error NotImplementedError
    end
  end

  describe "#qualifies_for_promotion?" do
    it "should raise not implemented exception" do
      expect{@promo.qualifies_for_promotion?}.to raise_error NotImplementedError
    end
  end

  describe "#adjustment_amount" do
    it "should raise not implemented exception" do
      expect{@promo.adjustment_amount}.to raise_error NotImplementedError
    end
  end

end
