require 'multi_buy_line_item_promotion'
require 'product'

describe MultiBuyLineItemPromotion do

  let(:product1) do
    Product.new('001', 'Very Cheap Chair', 9.25)
  end

  let(:product2) do
    Product.new('002', 'Little Table', 45.00)
  end

  let(:product3) do
    Product.new('003', 'Funky Light', 19.95)
  end

  let(:valid_promotion) do
    MultiBuyLineItemPromotion.new('001', 2, -0.75)
  end

  let(:qualifying_scanned_items) do
    {scanned_items: [product1, product2, product1]}
  end


  describe ".new" do
    context "when valid values are set" do

      it "no_items_required_to_qualify should equal 2" do
        expect(valid_promotion.no_items_required_to_qualify).to eq 2
      end

      it "discount_per_item should equal -0.75" do
        expect(valid_promotion.discount_per_item).to eq -0.75
      end
    end

    context "when invalid parameters are set" do
      it "should raise error if no_items_required_to_qualify is <= 0" do
        expect{MultiBuyLineItemPromotion.new('001', 0, -0.75)}.to raise_error ArgumentError
      end
    end
  end # end .new

  describe "#adjustment_type" do
    it "should equal LINE_ITEM_ADJUSTMENT" do
      expect(valid_promotion.adjustment_type).to eq 'LINE_ITEM_ADJUSTMENT'
    end
  end # end #adjustment_type


  describe "#qualifies_for_promotion?" do

    context "when scanned_items qualify for promotion" do

      it "should return true when there are enough of the correct item to qualify" do
        expect(valid_promotion.qualifies_for_promotion?(qualifying_scanned_items)).to be true
      end
    end

    context "when scanned_items do not qualify for promotion" do
      it "should return false if there are not enough of the qualifying item (product1)" do
        expect(valid_promotion.qualifies_for_promotion?({scanned_items: [product1, product2]})).to be false
      end

      it "should return false if are enought of the wrong item" do
        expect(valid_promotion.qualifies_for_promotion?({scanned_items: [product2, product2]})).to be false
      end

      it "should return false if there are no scanned items" do
        expect(valid_promotion.qualifies_for_promotion?({scanned_items: []})).to be false
      end
    end
  end #qualifies_for_promotion?

  describe "#adjustment_amount" do
    context "when qualifies for the promotion" do
      it "should return the discount_per_item value of -0.75" do
        expect(valid_promotion.adjustment_amount(qualifying_scanned_items)).to eq -0.75
      end
    end

    context "when doesn't qualify for the promotion" do
      it "should return 0.0" do
        expect(valid_promotion.adjustment_amount({scanned_items: [product2, product3]})).to eq 0.0
      end
    end
  end #adjustment_amount

end
