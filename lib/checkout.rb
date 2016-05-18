require_relative 'basket'

class Checkout

  attr_accessor :payment, :basket
  # attr_reader :basket

  # initialize checkout with item code that has a promotion and the amount that
  # triggers the promotion eg '001', 2
  def initialize(item_code, trigger)
    @basket = Basket.new
    @payment = {
      tender: 0,
      change: 0
    }
    @promo = {
      item: item_code,
      trigger: trigger
    }
  end

  def scan(item_code)
    @basket.scan(item_code)
  end

  def submit_basket(trigger = @promo[:trigger], item_code = @promo[:item])
    @basket.apply_promo(trigger,item_code)
    over_60_disc
  end

  def clear_basket
    @basket.clear
  end

  def pay(amount)
    @payment[:tender] = amount
    @payment[:change] = @payment[:tender] - @basket.basket_total
  end

  private
  def over_60_disc
    if @basket.basket_total > 60.00
      @basket.basket_total *= 0.9
      @basket.basket_total = @basket.basket_total.round(2)
    else
      @basket.basket_total 
    end
  end
end
