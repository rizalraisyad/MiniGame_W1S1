require_relative '../src/increment_array'

RSpec.describe IncrementingArray do
  it '[1] expected [2]' do
    incrementingArray = IncrementingArray.new
    
    result = incrementingArray.increment([1])

    expect(result).to eq([2])
  end
end