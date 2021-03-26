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
    describe '#trailing_space' do
        it 'returns true if there is a trailing space and false when there is no trailing space' do
            line3 = ' if block_given? '
            line4 = 'if block_given?'
            expect(check.trailing_space(line3)).to eq(true)
            expect(check.trailing_space(line4)).to eq(false)
        end
    end

    describe '#check_keywords' do
        it 'returns true and keyword name' do
            expect(check.check_keywords(line1).to eq([true, 'def ']))
        end
        it 'returns false array if not contain the keywords' do
            expect(check.check_keywords(line2)).to eq([false])
        end
    end

    # describe '#keyword_count' do
    #     it 'return the keyword count and the line number' do
    #         expect(check.keyword_count(file)).to eq(res)
    #     end
    # end

    describe '#block' do
        it 'counts no of blocks and ends' do
            expect(check.block(file)).to eq(4)
        end
    end
end