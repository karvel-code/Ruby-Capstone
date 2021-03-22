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
            key = ["if unless"]
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
end

end