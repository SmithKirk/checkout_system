require_relative 'price_list'

class Basket

  attr_accessor :basket, :basket_total
  attr_reader :price_list

  def initialize
    @basket = []
    @price_list = Price_list.new.prices
  end


  def scan(item_code)
    raise 'Warning item not found' unless valid_item?(item_code)
    sum_basket
  end

  def clear
    @basket = []
    sum_basket
  end

  def sum_basket
    @basket_total = sum_hash_values
  end

  def apply_promo(trigger,item_code)
    counts = Hash.new 0
    basket.each{|item| counts[item[:item_code]] += 1}
    if counts[item_code] >= trigger
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
  def sum_hash_values
    basket.inject(0){|sum, hash| sum + hash[:value]}
  end

  def valid_item?(item_code)
    if @price_list.has_key?(item_code)
      add_item_to_basket(item_code)
    end
  end

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
