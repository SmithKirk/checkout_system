require 'basket'

describe 'Basket' do

  subject(:basket){Basket.new}

  describe '#scan' do
    it 'scan adds item to basket' do
      basket.scan('001')
      expect(basket.basket).to include(
          {:basket_id => 1,
          :item_code => "001",
          :item => "Travel Card Holder",
          :value => 9.25})
    end

    it 'alerts user if item not found' do
      expect{basket.scan('01')}.to raise_error'Warning item not found'
    end
  end

  describe '#sum_basket' do
    it 'provides a total for items in basket' do
      basket.scan('001')
      basket.scan('002')
      expect(basket.basket_total).to eq 54.25
    end
  end

  describe '#apply_promo' do
    it 'travel card discount applied correctly' do
      basket.scan('001')
      basket.scan('001')
      basket.apply_promo('001')
      expect(basket.basket_total).to eq 17.00
    end

  end

  describe '#clear_basket' do
    it 'removes items from basket' do
      basket.scan('001')
      basket.scan('002')
      basket.clear
      expect(basket.basket).to eq []
    end

    it 'basket total should be 0' do
      basket.scan('001')
      basket.scan('002')
      basket.clear
      expect(basket.basket_total).to eq 0
    end
  end
end
