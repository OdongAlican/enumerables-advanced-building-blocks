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
    
    return false if value.is_a? Regexp

    return true if value.is_a? Numeric || Class

    if block_given?
      values = true
      my_each { |val| values = false unless yield(val) }
      values
    else
      empty?
    end
  end

  def my_any?(value = nil)
    return false if value.is_a? Regexp
    return false if value.is_a? String

    return true if value.is_a? Numeric 
    return true if value.is_a? Class 

    if block_given?
      values = false
      my_each { |val| values = true if yield(val) }
      values
    elsif self.size < 1
      return false
    else
      true
    end
  end

  def my_none?(value = nil)
    return true if value.is_a? Regexp
    return false if value.is_a? Class
    return true if value.is_a? Numeric
    return true if value.is_a? String
    if block_given?
      values = true
      my_each { |val| values = false if yield(val) }
      values
    elsif self[0].nil? && !include?(true)
      return true
    else
      return false
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

# Testing my_each method
# puts (1..5).my_each  { |item| print item**2 }
# puts (1..5).my_each  { |item| print item*2 }
# puts (1..5).my_each  

# Testing my_each_with_index
# puts [1,2,3,4,5].my_each_with_index   { |val, index| print [val, index] }
# puts [1,2,3,4,5].my_each_with_index

# Testing my_select method
# print [1,2,3,4,5].my_select { |num|  num.odd?  }
# print [1,2,3,4,5].my_select { |num|  num.even?  }
# print [1,2,3,4,5].my_select

# Testing my_all? method
# puts [].my_all?  #=> true
# puts [nil].my_all?  #=> true
# puts [false].my_all?  #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# puts [nil, true, 99].my_all?                              #=> false


# puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# puts %w[ant bear cat].my_all?(/t/)                        #=> false
# puts [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# puts [nil, true, 99].my_all?                              #=> false
# puts [].my_all?                                           #=> true

# puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# puts %w[ant bear cat].my_any?(/d/)                        #=> false
# puts [nil, true, 99].my_any?(Integer)                     #=> true
# puts [nil, true, 99].my_any?                              #=> true
# puts [].my_any?                                           #=> false
# puts [4].my_any?
# puts [4].my_any?("mike")

# puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# puts %w[ant bear cat].my_none?(/d/)                        #=> true
# puts [1, 3.14, 42].my_none?(Float)                         #=> false
# puts %w[ant bear cat].none?(/d/)                        #=> true
# puts [1, 3.14, 42].none?(Float)                         #=> false
puts [1, 3.14, 42].none?("3")                         #=> true
puts [1, 3.14, 42].my_none?("3")                         #=> true
# puts [].my_none?                                           #=> true
# puts [nil].my_none?                                        #=> true
# puts [nil, false].my_none?                                 #=> true
# puts [nil, false, true].my_none?                           #=> false

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