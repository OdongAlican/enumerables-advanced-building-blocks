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
  end
  
  # Testing my_each method
  puts (1..5).my_each  { |item| print item**2 }
  puts (1..5).my_each  { |item| print item*2 }
  
  # Testing my_each_with_index
  [1,2,3,4,5].my_each_with_index   { |val, index| print [val, index] }
  
  