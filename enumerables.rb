module Enumerable
  def my_each
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
    (0...size).each do |i|
      yield(self[i], i)
    end
    self
  end

  def my_select
    values = []
    my_each do |val|
      values.push(val) if yield(val)
    end
    values
  end

  def my_all?
    if block_given?
      values = true
      my_each { |val| values = false unless yield(val) }
      values
    else
      empty?
    end
  end

  def my_any?
    if block_given?
      values = false
      my_each { |val| values = true if yield(val) }
      values
    else
      true
    end
  end

  def my_none?
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

# Testing my_each_with_index
# [1,2,3,4,5].my_each_with_index   { |val, index| print [val, index] }

# Testing my_select method
# print [1,2,3,4,5].my_select { |num|  num.odd?  }
# print [1,2,3,4,5].my_select { |num|  num.even?  }

# Testing my_all? method
# puts [].my_all?  #=> true
# puts [nil].my_all?  #=> true
# puts [false].my_all?  #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# puts [nil, true, 99].my_all?                              #=> false

# Testing my_any? method
# puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# puts [nil, true, 99].my_any?                              #=> true

# Testing my_none? method
# puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# puts [].my_none?                                           #=> true
# puts [nil].my_none?                                        #=> true
# puts [nil, false].my_none?                                 #=> true

# Testing my_count method
# puts [1,2,3,4,5].my_count { |num| num > 0 }

# Testing my_map method
# puts (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]

# Testing my_inject method
# puts (4..10).my_inject { |sum, n| sum * n } #=> 45
# puts (4..10).inject(1) { |sum, n| sum * n } #=> 45
# puts [2,4,5].multiply_els                   #=> 40
# longest = %w{ cat sheep bear }.my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# puts longest
