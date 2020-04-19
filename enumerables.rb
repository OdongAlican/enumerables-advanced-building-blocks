module Enumerable
  def my_each

    return to_enum(:my_each) unless block_given?

    index = 0
    while index < size
      if is_a? Array
        yield self[index]
      elsif is_a? Range
        yield to_a[index]
      end
      index += 1
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    (0...size).each do |i|
      yield(self[i], i)
    end
    self
  end

  def my_select

    return to_enum(:my_select) unless block_given?

    values = []
    my_each do |val|
      values.push(val) if yield(val)
    end
    values
  end

  def my_all?(value = nil)
    
    if block_given?
      values = true
      my_each { |val| values = false unless yield(val) }
      values
    elsif !block_given? && value.is_a?(Numeric) && self.size < 1
      return true
    elsif !block_given? && value.is_a?(Numeric) && self.size > 0
      return false
    elsif !block_given? && value.is_a?(String) && self.size < 1
      return true
    elsif !block_given? && value.is_a?(String) && self.size > 0
      return false
    elsif !block_given? && value.is_a?(Regexp) && self.size < 1
      return true
    elsif !block_given? && value.is_a?(Regexp) && self.size > 0
      return false
    elsif !block_given? && value.is_a?(Class)
      values = true
      my_each { |val| values = false unless val.is_a?(value) }
      values
    elsif self.include?(nil) || self.include?(false)
      return false
    elsif !block_given? && value === nil
      return true
    end
  end

  def my_any?(value = nil)

    if block_given?
      values = false
      my_each { |val| values = true if yield(val) }
      values
    elsif !block_given? && value.is_a?(Regexp)
      return false
    elsif !block_given? && value.is_a?(Numeric)
      values = false
      my_each { |val| values = true if val == value }
      values
    elsif !block_given? && value.is_a?(String)
      values = false
      my_each { |val| values = true if val == value }
      values
    elsif !block_given? && value.is_a?(Class)
      values = false
      my_each { |val| values = true if val.is_a?(value) }
      values  
    elsif !block_given? && value == nil
      values = false
      my_each { |val| values = true if val}
      values 
    else
      return true
    end
  end

  def my_none?(value = nil)

    if block_given?
      values = true
      my_each { |val| values = false if yield(val) }
      values
    elsif !block_given? && value.is_a?(Regexp)
      return true
    elsif !block_given? && value.is_a?(Numeric)
      values = true
      my_each { |val| values = false if val == value}
      values 
    elsif !block_given? && value.is_a?(String)
      values = true
      my_each { |val| values = false if val == value}
      values 
    elsif !block_given? && value.is_a?(Class)
      values = true
      my_each { |val| values = false if val.is_a?(value) }
      values  
    elsif !block_given? && value == nil
      values = true
      my_each { |val| values = false if val}
      values 
    end
    values
  end

  def my_count
    count = 0
    my_each do |num|
      count += 1 if yield(num)
    end
    count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    mapped = []
    my_each do |i|
      mapped << (proc.nil? ? proc.call(i) : yield(i))
    end
    mapped
  end

  def my_inject
    result = first
    updated_result = []
    each do |item|
      updated_result << item
    end
    updated_result.delete_at(0)

    updated_result.each do |val|
      result = yield(result, val)
    end
    result
  end

  def multiply_els
    my_inject { |result, num| result * num }
  end
end


# Testing my_count method
# puts [1,2,3,4,5].my_count { |num| num > 0 }

# Testing my_map method
# puts (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
# puts (1..4).my_map 

# Testing my_inject method
# puts (4..10).my_inject { |sum, n| sum * n } #=> 45
# puts (4..10).inject(1) { |sum, n| sum * n } #=> 45
# puts [2,4,5].multiply_els                   #=> 40
# longest = %w{ cat sheep bear }.my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# puts longest

# puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# # %w[ant bear cat].my_all?(/t/)                        #=> false
# # [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# puts [nil, true, 99].my_all?                              #=> false
# puts [].my_all?                                           #=> true
# puts [1].my_all?                                           #=> true