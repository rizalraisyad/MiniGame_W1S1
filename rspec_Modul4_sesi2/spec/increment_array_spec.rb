require_relative '../src/increment_array'

RSpec.describe IncrementingArray do
  it '[1] expected [2]' do
    incrementingArray = IncrementingArray.new
    
    result = incrementingArray.increment([1])

    expect(result).to eq([2])
  end
  it '[9] expected [1,0]' do
    incrementingArray = IncrementingArray.new
    
    result = incrementingArray.increment([9])
  
    expect(result).to eq([1,0])
  end

  it '[1,0] expected [1,1]' do
    incrementingArray = IncrementingArray.new
    
    result = incrementingArray.increment([1,0])
  
    expect(result).to eq([1,1])
  end

  it '[5,6,1] expected [5,6,2]' do
    incrementingArray = IncrementingArray.new
    
    result = incrementingArray.increment([5,6,1])
  
    expect(result).to eq([5,6,2])
  end

  it '[1,0,0,0] expected [9,9,9]' do
    incrementingArray = IncrementingArray.new
    
    result = incrementingArray.increment([9,9,9])
  
    expect(result).to eq([1,0,0,0])
  end

  it '[9,9] expected [1,0,0]' do
    incrementingArray = IncrementingArray.new
    
    result = incrementingArray.increment([9,9])
  
    expect(result).to eq([1,0,0])
  end

  it '[3,9] expected [4,0]' do
    incrementingArray = IncrementingArray.new
    
    result = incrementingArray.increment([3,9])
  
    expect(result).to eq([4,0])
  end
end