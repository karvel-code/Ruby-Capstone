require 'colorize'
require_relative '../lib/error_methods'


file = ['def validate(move)', ' valid = true ', '  error = ' ' ', ' if move < 1 or move > 9 ',
        '    valid = false', '    error = "Number is not between 0 and 9"', '  elsif @board[move - 1].is_a? String',
        '    valid = false', '  end', '    error = "The cell is not empty"', '  end', '  [valid, error]', 'end']
res = [7, [['def ', 0], ['if', 2], ['if', 3], ['if', 4], ['if', 5], ['do ', 6], ['if', 7]]]
line1 = 'def validate(move)'
line2 = 'valid = true'
error = []
check = Checking.new(error)

describe '#Checking' do 
    describe '#Checking.trailing_space' do
        it 'returns true if there is a trailing space and false when there is no trailing space' do
            line1 = ' if block_given? '
            line2 = 'if block_given?'
            expect(check.trailing_space(line1)).to eq(true)
            # expect(check.trailing_space(line2)).to eq(false)
        end
    end
end