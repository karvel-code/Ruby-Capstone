require 'colorize'
require_relative '../lib/error_methods'

file = ['def validate(move)', ' valid = true ', "  error = ' ' ", ' if move < 1 or move > 9 ',
        '    valid = false', '    error = "Number is not between 0 and 9"', '  elsif @board[move - 1].is_a? String',
        '    valid = false', '    error = "The cell is not empty"', '  end', '  [valid, error]', 'end']
file_two = []
str = [3, [['def', 0], ['if', 3], ['if', 6]]]
line1 = 'if move < 1 or move > 9'
line2 = 'valid = true'
error = []
check = Checking.new(error)

describe '#Checking' do
  describe '#trailing_space' do
    it 'returns true if there is a trailing space and false when there is no trailing space' do
      line3 = "error = ' '   "
      expect(check.trailing_space(line3)).to eq(true)
    end
    it 'returns false if there is no trailing space detected' do
      line4 = 'if move < 1 or move > 9'
      expect(check.trailing_space(line4)).to eq(false)
    end
  end

  describe '#check_keywords' do
    it 'returns false array if not contain the keywords' do
      expect(check.check_keywords(line2)).to eq([false])
    end
    it 'returns true and keyword name' do
      expect(check.check_keywords(line1)).to match_array([true, 'if'])
    end
  end

  describe '#keyword_count' do
    it 'return the keyword count and the line number' do
      expect(check.keyword_count(file)).to eq(str)
    end
    it 'returns zero and empty array if there is no keyword detected' do
      expect(check.keyword_count(file_two)).to eq([0, []])
    end
  end

  describe '#block' do
    it 'counts no of blocks with ends' do
      expect(check.block(file)).to eq(2)
    end
    it 'returns zero when no blocks with ends are detected' do
      expect(check.block(file_two)).to eq(0)
    end
  end

  describe 'check_end' do
    it 'returns the total number of ends' do
      expect(check.check_end(file)).to eq(2)
    end
    it 'returns zero as the total when there are not ends detected' do
      expect(check.check_end(file_two)).to eq(0)
    end
  end

  describe 'last_end' do
    it 'returns last line number or position that holds last end' do
      expect(check.last_end(file)).to eq(11)
    end
    it 'returns nil when there is no end existing in the code' do
      expect(check.last_end(file_two)).to eq(nil)
    end
  end

  describe '#count_space' do
    it 'counts the spaces at the begining of a line' do
      expect(check.count_space(file)).to eq(0)
    end
    it 'returns zero when the file is empty' do
      expect(check.count_space(file_two)).to eq(0)
    end
  end
end
