class IncrementingArray
  def increment(numbers)
    index = numbers.length
    index -= 1
    temp_increment = 1
    while index >= 0
      numbers[index] += temp_increment
      temp_increment -= 1 if temp_increment>0
      if index - 1 >= 0
        if numbers[index] == 10
          numbers[index] = 0
          temp_increment += 1
        end
      elsif index - 1 < 0
        if numbers[index] == 10
          numbers[index] = 0
          numbers.unshift(1)
        end
      end
      index -=1
    end
    numbers
  end
end