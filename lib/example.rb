def validate(move)
  valid = true
  error = ' '
  if move < 1 or move > 9
    valid = false
    error = 'Number is not between 0 and 9'
  elsif @board[move - 1].is_a? String
    valid = false
    error = 'The cell is not empty'
  end
  [valid, error]
end
