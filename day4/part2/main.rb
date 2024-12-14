def main(filename, result = nil)
    sum = 0
    file_input = File.read(filename).split 
    height = file_input.length()
    width = file_input[0].length()
    (1..height-2).each { |h|
        (1..width-2).each {|w|
            reg = /MAS|SAM/
            w1 = [file_input[h-1][w-1],file_input[h][w],file_input[h+1][w+1]].join
            w2 = [file_input[h+1][w-1],file_input[h][w],file_input[h-1][w+1]].join
            diag_cross = reg.match(w1) != nil && reg.match(w2) != nil
            sum += 1 if diag_cross
        }
    }
    
    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end
puts "Test file"
main("test", 9)
puts "Input file"
main("input")
