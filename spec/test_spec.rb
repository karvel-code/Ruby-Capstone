require 'colorize'
require_relative '../lib/error_methods'


file = ['def validate(move)', ' valid = true ', '  error = ' ' ', ' if move < 1 or move > 9 ',
        '    valid = false', '    error = "Number is not between 0 and 9"', '  elsif @board[move - 1].is_a? String',
        '    valid = false','    error = "The cell is not empty"', '  end', '  [valid, error]', 'end']
res = [3, [["def", 0], ["if", 3], ["if", 6]]]
line1 = 'if move < 1 or move > 9'
line2 = 'valid = true'
error = []
check = Checking.new(error)

describe '#Checking' do 
    describe '#trailing_space' do
        it 'returns true if there is a trailing space and false when there is no trailing space' do
            line3 = ' if block_given? '
            line4 = 'if block_given?'
            expect(check.trailing_space(line3)).to eq(true)
            expect(check.trailing_space(line4)).to eq(false)
        end
    end

    describe '#check_keywords' do
        it 'returns false array if not contain the keywords' do
            expect(check.check_keywords(line2)).to eq([false])
        end
        it 'returns true and keyword name' do
            expect(check.check_keywords(line1)).to match_array([true, "if"])
        end
    end

    describe '#keyword_count' do
        it 'return the keyword count and the line number' do
            expect(check.keyword_count(file)).to eq(res)
        end
    end

    describe '#block' do
        it 'counts no of blocks and ends' do
            expect(check.block(file)).to eq(2)
        end
    end

    describe 'check_end' do
        it 'returns the count of ends' do
        expect(check.check_end(file)).to eql(2)
        end
    end

    describe 'last_end' do
        it 'returns last line number which contain last end' do
          expect(check.last_end(file)).to eql(11)
        end
    end
    
  describe '#count_space' do
    it 'counts the spaces at the begining of a line' do
      expect(check.count_space(file)).to eql(0)
    end
  end
end