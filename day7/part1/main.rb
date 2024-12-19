def main(filename, result = nil)
    sum = 0

    file_input = File.read(filename).split("\n")

    file_input.each do |line|
        res, nbs = line.split(": ")
        res = res.to_i
        nbs = nbs.split(" ").map { |s| s.to_i }
        perms = ["+", "*"].repeated_permutation(nbs.length()-1).to_a

        perms.each do |ops|
            calc = nbs[0]
            ops.each_with_index do |op, i|
                if(op == "+") 
                    calc += nbs[i+1]
                else
                    calc *= nbs[i+1]
                end
            end
            if(res == calc.to_i)
                sum += res
                break
            end
        end

    end
    

    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end
puts "Test file"
main("test", 143)
puts "Input file"
main("input")