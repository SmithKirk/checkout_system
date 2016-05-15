require_relative 'price_list'

class Checkout

  attr_writer :basket, :basket_total
  attr_reader :basket, :basket_total

  def initialize
    @basket = []
    @price_list = Price_list.new.prices
  end

  def scan(item)
    if @price_list.has_key?(item)
      add_item_to_basket(item)
    else
      raise 'Warning item not found'
    end
  end

  def sum_basket
    @basket_total = basket.inject(0){|sum, hash| sum + hash[:value]}
  end



  private
  def add_item_to_basket(item)
    item_details = {}
    item_details[:basket_id] = basket.size + 1
    item_details[:item_code] = item
    item_details[:item] = @price_list.fetch(item)[0]
    item_details[:value] = @price_list.fetch(item)[1]
    @basket << item_details
  end

end
