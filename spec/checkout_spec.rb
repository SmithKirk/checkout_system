require 'checkout'

describe 'Checkout' do

  subject(:checkout){Checkout.new}

  describe '#scan' do
    it 'scan adds item to basket' do
      checkout.scan('001')
      expect(checkout.basket).to include(
          {:basket_id => 1,
          :item_code => "001",
          :item => "Travel Card Holder",
          :value => 9.25})
    end

    it 'alerts user if item not found' do
      expect{checkout.scan('01')}.to raise_error'Warning item not found'
    end
  end

  describe '#sum_basket' do
    it 'provides a total for items in basket' do
      checkout.scan('001')
      checkout.scan('002')
      expect(checkout.basket_total).to eq 54.25
    end
  end

  describe '#pay' do
    it 'calculates correct change' do
      checkout.scan('001')
      checkout.scan('002')
      checkout.pay(60.00)
      expect(checkout.payment[:change]).to eq 5.75
    end
  end

  describe 'apply_discount' do
    it 'travel card disount applied correctly' do
      checkout.scan('001')
      checkout.scan('001')
      checkout.apply_discount('001')
      expect(checkout.basket_total).to eq 17.00
    end

    it 'baskets over £60 get 10% off' do
      checkout.scan('002')
      checkout.scan('003')
      checkout.over_60_disc
      expect(checkout.basket_total).to eq 58.46
    end
  end

  describe 'test baskets' do
    it '001, 002, 003' do
      checkout.scan('001')
      checkout.scan('002')
      checkout.scan('003')
      checkout.over_60_disc
      expect(checkout.basket_total).to eq 66.78
    end

    it '001, 003, 001' do
      checkout.scan('001')
      checkout.scan('003')
      checkout.scan('001')
      checkout.apply_discount('001')
      expect(checkout.basket_total).to eq 36.95
    end

    it '001, 002, 001, 003' do
      checkout.scan('001')
      checkout.scan('002')
      checkout.scan('001')
      checkout.scan('003')
      checkout.apply_discount('001')
      checkout.over_60_disc
      expect(checkout.basket_total).to eq 73.76
    end
  end
end
