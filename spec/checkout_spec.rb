require 'checkout'

describe 'Checkout' do

  subject(:checkout){Checkout.new('001', 2)}

  describe '#pay' do
    it 'calculates correct change' do
      checkout.scan('001')
      checkout.scan('002')
      checkout.pay(60.00)
      expect(checkout.payment[:change]).to eq 5.75
    end
  end

  describe '#submit_basket' do
    it 'applies over £60 discount' do
      checkout.scan('002')
      checkout.scan('003')
      checkout.submit_basket
      expect(checkout.basket.basket_total).to eq 58.46
    end
  end

  describe 'test baskets' do
    it '001, 002, 003' do
      checkout.scan('001')
      checkout.scan('002')
      checkout.scan('003')
      checkout.submit_basket
      expect(checkout.basket.basket_total).to eq 66.78
    end

    it '001, 003, 001' do
      checkout.scan('001')
      checkout.scan('003')
      checkout.scan('001')
      checkout.submit_basket
      expect(checkout.basket.basket_total).to eq 36.95
    end

    it '001, 002, 001, 003' do
      checkout.scan('001')
      checkout.scan('002')
      checkout.scan('001')
      checkout.scan('003')
      checkout.submit_basket
      expect(checkout.basket.basket_total).to eq 73.76
    end
  end
end
