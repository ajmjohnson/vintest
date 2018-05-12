require 'checkout'

describe Checkout do

  #PROMOTIONS
  let(:line_item_promotion) do
    MultiBuyLineItemPromotion.new('001', 2, -0.75)
  end

  let(:order_total_promotion) do
    OrderTotalPromotion.new(60,10)
  end

  let(:promotional_rules) do
    [line_item_promotion, order_total_promotion]
  end

  #PRODUCTS
  let(:product1) do
    Product.new('001', 'Very Cheap Chair', 9.25)
  end

  let(:product2) do
    Product.new('002', 'Little Table', 45.00)
  end

  let(:product3) do
    Product.new('003', 'Funky Light', 19.95)
  end

  # BASKETS
  let(:basket1) do
    [product1, product2, product3]
  end

  let(:basket2) do
    [product1, product3, product1]
  end

  let(:basket3) do
    [product1, product2, product1, product3]
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

    context "when an item is scanned" do
      it "should be added to the scanned_items in the checkout" do
        checkout.scan(product1)
        expect(checkout.scanned_items).to eq [product1]
      end
    end

    context "when all items in basket1 are scanned" do
      it "the scanned_items in the checkout should match the basket items" do
        basket1.each do |item|
          checkout.scan(item)
        end
        expect(checkout.scanned_items).to eq basket1
      end
    end

  end #end #scan

  describe "#total" do

    let(:checkout) do
      Checkout.new(promotional_rules)
    end

    it 'should have a total of £66.78 for basket 1' do
      basket1.each do |item|
        checkout.scan(item)
      end
      expect(checkout.total).to eq '£66.78'
    end

    it 'should have a total of £36.95 for basket 2' do
      basket2.each do |item|
        checkout.scan(item)
      end
      expect(checkout.total).to eq '£36.95'
    end

    it 'should have a total of £73.76 for basket 3' do
      basket3.each do |item|
        checkout.scan(item)
      end
      expect(checkout.total).to eq '£73.76'
    end

  end #end #total

end
