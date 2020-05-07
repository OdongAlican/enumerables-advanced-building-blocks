require_relative '../enumerables.rb'

describe Enumerable do
  let(:arr) { (1..3).to_a }
  let(:word) { %w[dog door rod blade] }
  describe '#my_each' do
    it 'return each element in the array' do
      expect { |b| arr.my_each(&b) }.to yield_successive_args(1, 2, 3)
    end

    it 'returns an enumerator if no block is given' do
      expect(arr.my_each).to be_an Enumerator
    end
  end

  describe '#my_each_with_index' do
    it "returns array's element and its index" do
      expect { |b| arr.my_each_with_index(&b) }.to yield_successive_args([1, 0], [2, 1], [3, 2])
    end

    it 'returns an enumerator if no block is given' do
      expect(arr.my_each_with_index).to be_an Enumerator
    end
  end
  describe '#my_select' do
    it 'returns array elements for which the given block returns a true value' do
      expect { |b| arr.my_select(&b) }.to yield_control
    end

    it 'returns an enumerator if no block is given' do
      expect(arr.my_select).to be_an Enumerator
    end
  end

  describe '#my_all?' do
    it 'returns true if the block never returns false ' do
      expect { |b| arr.my_all?(&b) }.to yield_control
    end

    it 'returns true if all values match as Integers' do
      expect(arr.my_all?(Integer)).to be true
    end

    it 'returns true if all values match the regexp' do
      expect(word.my_all?(/d/)).to be true
    end

    it 'returns true when none of the collection members is false' do
      expect(arr.my_all?).to be true
    end
  end

  describe '#my_any?' do
    it 'returns true if the block ever returns true ' do
      expect { |b| arr.my_any?(&b) }.to yield_control
    end

    it 'returns true if atleast one value match the arg' do
      expect(arr.my_any?(Integer)).to be true
    end

    it 'returns true if any values match the regexp' do
      expect(word.my_any?(/b/)).to be true
    end

    it 'returns true when atleast one of the collection members is true' do
      expect(arr.my_any?).to be true
    end
  end

  describe '#my_none?' do
    it 'returns true if the block never returns true' do
      expect { |b| arr.my_none?(&b) }.to yield_control
    end

    it 'returns true if all values do not match the arg' do
      expect(arr.my_none?(Integer)).to be false
    end

    it 'returns false if all values match the regexp' do
      expect(word.my_none?(/d/)).to be false
    end

    it 'returns true when none of the collection members is true' do
      expect(arr.my_none?).to be false
    end
  end
  describe '#my_count' do
    it 'returns the number of items yielding a true value' do
      expect { |b| arr.my_count(&b) }.to yield_control
    end

    it 'returns returns the number of items that are equal to the arg given' do
      expect(arr.my_count(2)).to eql(1)
    end

    it 'returns the length of the array if no args and block is given' do
      expect(arr.my_count).to eql(3)
    end
  end

  describe '#my_map' do
    it 'returns an array with the results of the block given' do
      expect { |b| arr.my_map(&b) }.to yield_control
    end

    it 'returns an arr with the results of the proc called' do
      proc = proc { |num| num > 10 }
      expect(arr.my_map(proc)).to eql([false, false, false])
    end

    it 'returns an enumerator if no block is given' do
      expect(arr.my_map).to be_an Enumerator
    end
  end

  describe '#my_inject' do
    it 'returns an accumulated value when yielded and with arg' do
      expect { |b| arr.my_inject(5, &b) }.to yield_control
    end

    it 'returns an accumulated value with no args' do
      expect { |b| arr.my_inject(&b) }.to yield_control
    end

    it 'uses the operator symbol as an accumulator' do
      expect(arr.my_inject(:+)).to eql(6)
    end

    it 'uses the operator symbol as an accumulator and starts uses the number arg as initial value' do
      expect(arr.my_inject(3, :+)).to eql(9)
    end
  end
end
