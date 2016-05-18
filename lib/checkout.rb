require_relative 'basket'

class Checkout

  attr_writer :basket, :basket_total, :payment
  attr_reader :basket, :basket_total, :payment

  def initialize(item_code)
    @basket = Basket.new
    @payment = {
      tender: 0,
      change: 0
    }
    @on_promo = item_code
  end

  def scan(item)
    @basket.scan(item)
  end

  def pay(amount)
    @payment[:tender] = amount
    @payment[:change] = @payment[:tender] - @basket.basket_total
  end

  def clear_basket
    @basket.clear
  end

  def submit_basket(item_code = @on_promo)
    @basket.apply_promo(item_code)
    over_60_disc
  end

  private

  def over_60_disc
    if @basket.basket_total > 60.00
      @basket.basket_total *= 0.9
      @basket.basket_total = @basket.basket_total.round(2)
    end
  end


end
