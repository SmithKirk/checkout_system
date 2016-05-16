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

  def apply_discount(item_code)
    counts = Hash.new 0
    basket.each{|item| counts[item[:item_code]] += 1}
    if counts[item_code] >= 2
      @basket.delete_if{|hash| hash[:item_code] == item_code}
      counts[item_code].times{
        item_details = {}
        item_details[:basket_id] = basket.size + 1
        item_details[:item_code] = item_code
        item_details[:item] = @price_list.fetch(item_code)[0]
        item_details[:value] = @price_list.fetch(item_code)[2]
        @basket << item_details}
        sum_basket
    end
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
