def find_xmas(line)
    return line.scan(/XMAS/).length()
end
def find_xmas_diag(file_input)
    sum = 0
    file_input.reverse.each_with_index
        .map{|s,i| " " * i + s }
        .inject(Array.new(file_input.size + file_input.last.size-1,"")) do |a,s| 
                s.chars.each_with_index do |c,i| 
                a[i] = c + a[i]
            end
            a
        end.each{ |s|
        sum += find_xmas(s)
    }
    return sum
end
def main(filename, result = nil)
    sum = 0
    file_input = File.read(filename).split 
    file_input.each_with_index { |line, i|
        sum += find_xmas(line)
    }
    sum += find_xmas_diag(file_input)
    3.times {
        file_input = file_input.map{|s| s.chars}.transpose.map(&:reverse).map{|s| s.join("")}
        file_input.each_with_index { |line, i|
            sum += find_xmas(line)
        }
        sum += find_xmas_diag(file_input)
    } 
    
    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end
puts "Test file"
main("test", 18)
puts "Input file"
main("input")