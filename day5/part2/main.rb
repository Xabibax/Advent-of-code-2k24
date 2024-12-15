def main(filename, result = nil)
    sum = 0
    rules = []
    updates = []
    file_input = File.read(filename).split 
    
    file_input.each do |line|
        if line.match(/\d*\|\d*/) 
            rules.push(line.split("|").map {|s| s.to_i})
        else
            valid_update = true
            update = line.split(",").map {|s| s.to_i}
            update.each_with_index { |n, i| 
                left_part = update[0,i-1]
                right_part = update[i+1,update.length()-i]
                rules.each do |rule|
                    if rule[0] == n && left_part != nil
                        if left_part.include? rule[1] 
                            valid_update = false
                            break
                        end
                    end   
                    if rule[1] == n && right_part != nil
                        if right_part.include? rule[0]
                            valid_update = false
                            break
                        end
                    end   
                end
            }
            updates.push(update) if !valid_update
        end
    end

    updates.each do |pages|
        sorted = pages.sort { |a,b| 
            swap = 0
            rules.each do |rule|
                if rule[0] == a  && rule[1] == b
                    swap = 1
                    break
                end
                if rule[1] == a  && rule[0] == b
                    swap =-1
                    break
                end
            end
            swap
        }
        sum += sorted[sorted.length()/2]
    end

    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end
puts "Test file"
main("test", 123)
puts "Input file"
main("input")