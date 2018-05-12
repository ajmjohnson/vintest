require 'checkout'

describe Checkout do

  let(:line_item_promotion) do
    MultiBuyLineItemPromotion.new('001', 2, -0.75)
  end

  # let(:order_total_promotion) do
  #   OrderTotalPromotion.new(60,10)
  # end

  let(:promotional_rules) do
    [line_item_promotion]
  end



  describe ".new" do
    context "when the checkout is initialized with promotions" do
      let(:checkout) do
        Checkout.new(promotional_rules)
      end

      it "should have no scanned items" do
        expect(checkout.scanned_items).to eq []
      end

      it "should have no scanned items" do
        expect(checkout.promotions).to be promotional_rules
      end
    end

    context "when the checkout is initialized with no promotions" do
      let(:checkout) do
        Checkout.new
      end

      it "should have no scanned items" do
        expect(checkout.scanned_items).to eq []
      end

      it "should have no scanned items" do
        expect(checkout.promotions).to eq []
      end
    end
  end #end .new

  describe "#scan" do

    let(:checkout) do
      Checkout.new
    end

    it "should add the item to the scanned_items array" do

    end

  end #end #scan

  describe "#total" do

  end #end #total

end
