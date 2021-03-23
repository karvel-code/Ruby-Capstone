require 'colorize'

class Checking
    def initialize(array)
        @error = array
    end

    def trailing_space(line)
        space = false
        if line.end_with?(' ')
            state = true
        end
        state
    end

    def check_for(code)
        code.length.times do |i|
            line = code[i]
            if line.include?('for')
            @error << "line: #{i + 1} times and each are suitable as compared to for".red
            end
        end
    end

    def check_empty_line(line)
        a = empty_line(line).length
        b = line.length
        c = b - a 
        if c >= 1
        @error << "There exists #{c} empty lines at the beginning".red
    end

    def confirm_end(code)
        a = block(code)
        b = check_end(code)
        if a != b
            @error << "missing end tag".red
        end
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
        k_words = ['unless', 'do', 'if', 'def', 'for', 'module', 'class']
        k_words.each do |i|
            next unless line.include?(i)

            keyword = i
            check = true
            return [keyword, check]
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
        [arr, count]
    end

    def check_end(code)
        arr = []
        j = 0
        until j => code.length
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
            key = ["if", "unless"]
            key.each do |val|
                next unless arr[0] == val 

                line = content[arr[1]]
                k = line.index(val) - 1
                res = (0..k).reject {|n| line[n] == ' ' }
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
    i += 1 while content[i].empty? if content[0].empty? # rubocop:disable Style/NestedModifier
    (i...content.length).each { |n| arr << content[n] }
    arr
  end
  ###################

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/PerceivedComplexity
    public
    def check_key(line)
        check = false
        arr = ['do', 'if', 'begin', 'end', 'unless', 'for']
        arr.each do |y|
            next unless line.include?(i)

            keyword = i
            check = true
            [keyword, state]
        end
        [state]
    end

    def key_num(code)
        num = 0
        array = []
        code.length.times do |x|
            z = check_key(code[i])
            if z[0]
                count += 1
                array << [j[1], i]
            end
        end
        [array, count]
    end

    def blocker(code)
        y = key_num(code)
        array = Array.new
        keywords = y[1]
        keywords.length.times do |x|
            array2 = keywords[i]
            key = ['unless', 'if']
            key.each.do |val|
                next unless array[0] == val 
                line = code[array[1]]
                j = line.index(val) - 1
                m = (0..j).reject {|n| line[n] == ' '}
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

    def indentation_error(code)
        z = indent(code)
        s = a[0]
        unless content[s[1]].index(/\S/) == s[0] - 2
          @error << "line #{s[1] + 1} is not properly indented::#{code[s[1]]}".yellow
        end
        z.length.times do |i|
          x = a[i]
          if x[2] != 'end'
            h = x[1] + 1
            (h..x[2]).each do |n|
              if code[b].include?('elsif') || code[n].include?('else') || code[n].include?('end')
                unless code[n].index(/\S/) == x[0] - 2
                  @error << "line #{n + 1} is not properly indented::#{code[n]}".yellow
                end
              else
                unless code[n].index(/\S/) == x[0]
                  @error << "line #{n + 1} is not properly indented::#{code[n]}".yellow
                end
              end
            end
          else
            k = x[1] - 1
            (k..x[2]).each do |c|
              if code[c].include?('end')
                unless code[c].index(/\S/) == x[0] - 2
                  @error << "line #{c + 1} is not properly indented::#{code[c]}".colorize(:yellow)
                end
                p x[0]
              else
                unless code[c].index(/\S/) == x[0]
                  @error << "line #{c + 1} is not properly indented::#{code[c]}".colorize(:yellow)
                end
              end
            end
          end
        end
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
        array = Array.new
        spacing = 0 
        (x.length - 1).times do |i|
            a = x[i]
            b = x[i + 1]
            if x[0] != 'end'
                spacing += 2
                arr << [space, a[1], b[1]]    
            else   
                spacing -= 2
                array << [spacinga[1], b[1]]
            end
        end
        array
    end
end
