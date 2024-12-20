

def main(filename, result = nil)
    sum = 0

    file_input = File.read(filename).split.map { |s| s.to_i }

    25.times do |i|
        next_line = []
        file_input.each_with_index do |n, j|
            if n == 0
                next_line.push(1)
            elsif n.to_s.length().even?
                str = n.to_s
                left, right = [str[0..str.length/2-1], str[str.length/2..str.length-1]].map { |s| s.to_i }
                next_line.push(left)
                next_line.push(right)
            else 
                next_line.push(2024*n)
            end
        end
        file_input = next_line
    end

    sum += file_input.length()
    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end


puts "Test file"
main("test", 55312)
puts "Input file"
main("input")