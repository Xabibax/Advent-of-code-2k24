def main(filename, result = nil)
    sum = 0

    file_input = File.read(filename).split[0]

    res = []
    counter = 0
    file_input.split("").each_with_index do |c, i|
        for j in 1..c.to_i do
            if((i+1).even?)
                res.push('.')  
            else
                res.push(counter)   
            end              
        end  
        if((i+1).odd?)
          counter += 1
        end
    end

    for i in 0..res.length() do
        break if i >= res.length
        next if(res[i] != '.')
        res[i] = res[res.length-1]
        loop do
            res= res[0..res.length-2]
            break if (res[res.length-1] != '.')
        end
    end

    for i in 0..res.length()-1 do
        sum += res[i].to_i * i
    end


  

    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end
puts "Test file"
main("test", 1928)
puts "Input file"
main("input")