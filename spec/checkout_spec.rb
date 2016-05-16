require 'checkout'

describe 'Checkout' do

  subject(:checkout){Checkout.new}
  # let(:item){object_double(Item.new)}

  describe '#scan' do
    it 'scan adds item to basket' do
      checkout.scan('001')
      expect(checkout.basket).to include(
          {:basket_id => 1,
          :item_code => "001",
          :item => "Travel Card Holder",
          :value => 4.75})
    end

    it 'alerts user if item not found' do
      expect{checkout.scan('01')}.to raise_error'Warning item not found'
    end
  end

  describe '#sum_basket' do
    it 'provides a total for items in basket' do
      checkout.scan('001')
      checkout.scan('002')
      expect(checkout.basket_total).to eq 49.75
    end
  end

  describe '#pay' do
    it 'calculates correct change' do
      checkout.scan('001')
      checkout.scan('002')
      checkout.pay(50.00)
      expect(checkout.payment[:change]).to eq 0.25
    end
  end
end
