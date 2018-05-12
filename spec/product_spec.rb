require 'product'

describe Product do

  describe ".new" do
    context "when values are set" do
      let(:product) do
        Product.new('001', 'Very Cheap Chair', 9.25)
      end

      it "should have a code of '001'" do
        expect(product.code).to eq '001'
      end

      it "should have a name of 'Very Cheap Chair'" do
        expect(product.name).to eq 'Very Cheap Chair'
      end

      it "should have a price of '9.25'" do
        expect(product.price).to eq 9.25
      end
    end

    context "when values are not set" do

      it "should raise an error if no code is set" do
        expect{Product.new('', 'Chair', 0.0)}.to raise_error ArgumentError, 'code must be set'
      end

      it "should raise an error if no name is set" do
        expect{Product.new('001', '', 0.0)}.to raise_error ArgumentError, 'name must be set'
      end

      it "should raise an error if price is zero" do
        expect{Product.new('001', 'Chair', 0.0)}.to raise_error ArgumentError, 'price must greater than zero'
      end

      it "should raise an error if price is less than zero" do
        expect{Product.new('001', 'Chair', -1)}.to raise_error ArgumentError, 'price must greater than zero'
      end

    end

  end # end .new

end
