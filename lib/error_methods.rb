require 'colorize'

class Checking
  def initialize(array)
    @error = array
  end

  def trailing_space(line)
    space = false
    space = true if line.end_with?(' ')
    space
  end

  def check_for(code)
    code.length.times do |i|
      line = code[i]
      @error << "line: #{i + 1} times and each are suitable as compared to for".red if line.include?('for')
    end
  end

  def check_empty_line(line)
    a = empty_line(line).length
    b = line.length
    c = b - a
    @error << "There exists #{c} empty lines at the beginning".red if c >= 1
  end

  def confirm_end(code)
    a = block(code)
    b = check_end(code)
    @error << 'missing end tag'.red if a != b
  end

  def last_end(code)
    arr = []
    x = 0
    while x < code.length
      arr << x if code[x].include?('end')
      x += 1
    end
    y = arr.length
    arr[y - 1]
  end

  def check_keywords(line)
    check = false
    k_words = %w[unless do if def for module class]
    k_words.each do |i|
      next unless line.include?(i)

      keyword = i
      check = true
      return [check, keyword]
    end
    [check]
  end

  def keyword_count(code)
    count = 0
    arr = []

    code.length.times do |i|
      j = check_keywords(code[i])
      if j[0]
        count += 1
        arr << [j[1], i]
      end
    end
    [count, arr]
  end

  def check_end(code)
    arr = []
    j = 0
    until j == code.length
      arr << j if code[j].include?('end')
      j += 1
    end
    arr.length
  end

  def block(code)
    k = keyword_count(code)
    array = []
    keywords = k[1]
    keywords.length.times do |i|
      arr = keywords[i]
      key = %w[if unless]
      key.each do |val|
        next unless arr[0] == val

        line = code[arr[1]]
        k = line.index(val) - 1
        res = (0..k).reject { |n| line[n] == ' ' }
        array << i unless res.empty?
      end
    end
    keyword = []
    array.length.times do |i|
      keyword << keywords[array[i]]
    end
    keyword -= keyword
    keywords.length
  end

  private

  def empty_line(code)
    arr = []
    i = 0
    i += 1 while code[i].empty? if code[0].empty? # rubocop:disable Style/NestedModifier
    (i...code.length).each { |n| arr << code[n] }
    arr
  end

  ###################

  public

  def check_key(line)
    check = false
    arr = %w[do if begin end unless for]
    arr.each do |y|
      next unless line.include?(y)

      keyword = y
      check = true
      return [keyword, state]
    end
    [state]
  end

  def key_num(code)
    num = 0
    array = []
    code.length.times do |x|
      z = check_key(code[x])
      if z[0]
        num += 1
        array << [j[1], x]
      end
    end
    [array, count]
  end

  def blocker(code)
    y = key_num(code)
    array = []
    keywords = y[1]
    keywords.length.times do |x|
      array2 = keywords[i]
      key = %w[unless if]
      key.each do |val|
        next unless array2[0] == val

        line = code[array[1]]
        j = line.index(val) - 1
        m = (0..j).reject { |n| line[n] == ' ' }
        array << x unless m.empty?
      end
    end
    keyword = []
    array.length.times do |i|
      keyword << keywords[array[i]]
    end
    keywords -= keyword
    keywords
  end

  def count_space(line)
    a = 0
    line.length.times do |i|
      a += 1 if line[i] == ' '
      break if line[i] != ' '
    end
    a
  end

  def indent(code)
    x = blocker(code)
    array = []
    spacing = 0
    (x.length - 1).times do |i|
      a = x[i]
      b = x[i + 1]
      if x[0] != 'end'
        spacing += 2
        arr << [spacing, a[1], b[1]]
      else
        spacing -= 2
        array << [spacing, a[1], b[1]]
      end
    end
    array
  end
end
