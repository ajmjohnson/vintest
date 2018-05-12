class Product
  attr_accessor :code
  attr_accessor :name
  attr_accessor :price

  def initialize(code = '', name = '', price = 0.0)
    @code = code
    @name = name
    @price = price

    raise(ArgumentError, 'code must be set') if code == ''
    raise(ArgumentError, 'name must be set') if name == ''
    raise(ArgumentError, 'price must greater than zero') if price <= 0
  end


end
