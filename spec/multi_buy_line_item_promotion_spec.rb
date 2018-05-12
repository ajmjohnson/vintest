require 'multi_buy_line_item_promotion'

describe MultiBuyLineItemPromotion do

  describe ".new" do
    context "when valid values are set" do
      let(:promotion) do
        MultiBuyLineItemPromotion.new(2, 0.75)
      end

      it "no_items_required_to_qualify should equal 2" do
        expect(promotion.no_items_required_to_qualify).to eq 2
      end

      it "discount_per_item should equal 0.75" do
        expect(promotion.discount_per_item).to eq 0.75
      end
    end

    context "when invalid parameters are set" do
      let(:promotion) do
        MultiBuyLineItemPromotion.new(0, 0.75)
      end

      it "should raise error if no_items_required_to_qualify is <= 0" do
        expect{MultiBuyLineItemPromotion.new(0, 0.75)}.to raise_error ArgumentError
      end
    end


  end

end
