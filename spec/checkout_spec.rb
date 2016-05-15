require 'checkout'

describe 'Checkout' do

  subject(:checkout){Checkout.new}
  # let(:item){object_double(Item.new)}

  describe '#scan' do
    it 'scan adds item to basket' do
      checkout.scan('001')
      expect(checkout.basket).to include({1=> ["001", "Travel Card Holder",4.75]})
    end

    it 'alerts user if item not found' do
      expect{checkout.scan('01')}.to raise_error'Warning item not found'
    end
  end

  describe '#sum_basket' do
    it 'provides a total for items in basket' do
      checkout.scan('001')
      checkout.scan('002')
      checkout.sum_basket
      expect(checkout.basket_total).to eq 54.25
    end
  end
end
