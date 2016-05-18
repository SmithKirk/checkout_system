require_relative 'price_list'

class Basket

  attr_writer :basket, :basket_total, :item_code
  attr_reader :basket, :basket_total, :price_list

  def initialize
    @basket = []
    @price_list = Price_list.new.prices
  end


  def scan(item_code)
    if @price_list.has_key?(item_code)
      add_item_to_basket(item_code)
    else
      raise 'Warning item not found'
    end
    sum_basket
  end

  def clear
    @basket = []
    sum_basket
  end

  def sum_basket
    @basket_total = basket.inject(0){|sum, hash| sum + hash[:value]}
  end

  def apply_promo(item_code)
    counts = Hash.new 0
    basket.each{|item| counts[item[:item_code]] += 1}
    if counts[item_code] >= 2
      @basket.delete_if{|hash| hash[:item_code] == item_code}
      counts[item_code].times do
        @item_details = {}
        create_item(item_code)
        item_value(item_code, value ||= 2)
        @basket << @item_details
      end
      sum_basket
    end
  end

  private
  def add_item_to_basket(item_code)
    @item_details = {}
    create_item(item_code)
    item_value(item_code, value ||= 1)
    @basket << @item_details
  end

  def create_item(item_code)
    @item_details[:basket_id] = @basket.size + 1
    @item_details[:item_code] = item_code
    @item_details[:item] = @price_list.fetch(item_code)[0]
  end

  def item_value(item_code, value)
    @item_details[:value] = @price_list.fetch(item_code)[value]
  end

end
