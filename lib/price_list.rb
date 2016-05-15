require 'json'

class Price_list

  attr_reader :prices


  def initialize
    file = File.read('prices.json')
    @prices = JSON.parse(file)
  end
end
