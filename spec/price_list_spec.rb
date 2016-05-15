require 'price_list'

describe 'Price_list' do

  subject(:price_list){Price_list.new}

  it 'prices should have content ' do
    expect(price_list.prices).not_to be_empty
  end
end
