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
    elsif !block_given? && value.is_a?(Numeric)
      values = true
      my_each { |val| values = false if val != value}
      values 
    elsif !block_given? && value.is_a?(String)
      values = true
      my_each { |val| values = false if val != value}
      values 
    elsif !block_given? && value.is_a?(Regexp)
      values = true
      my_each { |val| values = false unless !val }
      values
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

  def my_count(val = nil)
    if block_given?
      count = 0
      my_each do |num|
        count += 1 if yield(num)
      end
    elsif !block_given? && val != nil
      count = 0
      my_each do |num|
        count += 1 if num == val
      end
    elsif !block_given? && val== nil
      return self.size
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

  def my_inject(value=nil, value_two=nil)
    if block_given? && value == nil
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
    elsif block_given? && value != nil
      result = first
      updated_result = []
      each do |item|
        updated_result << item
      end
      updated_result.delete_at(0)
  
      updated_result.each do |val|
        result = yield(result, val)
      end
      result = yield(result, value)
    elsif !block_given? && value == :* 
      result = first
    updated_result = []
    each do |item|
      updated_result << item
    end
    updated_result.delete_at(0)

    updated_result.each do |val|
      result = (result * val)
    end
    result
  elsif !block_given? && value != nil  && value_two == :*
    result = first
  updated_result = []
  each do |item|
    updated_result << item
  end
  updated_result.delete_at(0)

  updated_result.each do |val|
    result = (result * val)
  end
  result = result * value
  result
  elsif !block_given? && value == :+
    result = first
  updated_result = []
  each do |item|
    updated_result << item
  end
  updated_result.delete_at(0)

  updated_result.each do |val|
    result = (result + val)
  end
  result
elsif !block_given? && value !=nil && value_two == :+ 
  result = first
updated_result = []
each do |item|
  updated_result << item
end
updated_result.delete_at(0)

updated_result.each do |val|
  result = (result + val)
end
result = result + value
  end
  end

  def multiply_els
    my_inject { |result, num| result * num }
  end
end

