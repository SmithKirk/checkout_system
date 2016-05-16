require_relative 'price_list'

class Checkout

  attr_writer :basket, :basket_total, :payment
  attr_reader :basket, :basket_total, :payment

  def initialize
    @basket = []
    @price_list = Price_list.new.prices
    @payment = {
      tender: 0,
      change: 0
    }
  end

  def scan(item)
    if @price_list.has_key?(item)
      add_item_to_basket(item)
    else
      raise 'Warning item not found'
    end
    sum_basket
  end

  def sum_basket
    @basket_total = basket.inject(0){|sum, hash| sum + hash[:value]}
  end

  def pay(amount)
    @payment[:tender] = amount
    @payment[:change] = @payment[:tender] - @basket_total
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
