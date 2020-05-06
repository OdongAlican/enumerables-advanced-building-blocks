require_relative '../enumerables.rb'

describe Enumerable do
  let (:arr) { (1..3).to_a }
  let (:word) {%w[dog door rod blade]}
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
end