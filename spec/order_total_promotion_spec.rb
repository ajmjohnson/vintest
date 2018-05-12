require 'order_total_promotion'

describe OrderTotalPromotion do

  let(:valid_promotion) do
    OrderTotalPromotion.new(60,10)
  end

  describe ".new" do
    context "when valid values are set" do
      it "should have a min_total_to_qualify of 60" do
        expect(valid_promotion.min_total_to_qualify).to eq 60
      end

      it "should have a discount_percentage of 10" do
        expect(valid_promotion.discount_percentage).to eq 10
      end
    end
  end

  describe "#adjustment_type" do
    it "should equal ORDER_TOTAL_ADJUSTMENT" do
      expect(valid_promotion.adjustment_type).to eq 'ORDER_TOTAL_ADJUSTMENT'
    end
  end # end #adjustment_type

  describe "#qualifies_for_promotion?" do
    context "when qualifies for promotion" do
      it "should return true" do
        expect(valid_promotion.qualifies_for_promotion?({line_item_total: 70})).to be true
      end
    end

    context "when doesn't qualify for promotion" do
      it "should return false" do
        expect(valid_promotion.qualifies_for_promotion?({line_item_total: 59})).to be false
      end
    end
  end #end qualifies_for_promotion?


  describe "#adjustment_amount" do
    context "when qualifies for the promotion" do
      it "should return the 10% of line item total" do
        expect(valid_promotion.adjustment_amount({line_item_total: 70})).to eq -7.00
      end
    end

    context "when doesn't qualify for the promotion" do
      it "should return 0.0" do
        expect(valid_promotion.adjustment_amount({line_item_total: 59})).to eq 0.0
      end
    end
  end #adjustment_amount

end
