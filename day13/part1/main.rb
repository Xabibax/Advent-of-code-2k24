def main(filename, result = nil)
    sum = 0

    file_input = File.read(filename).split("\n")

    for i in 0..file_input.length/4
        b_a, b_b, prize = [file_input[i*4], file_input[i*4+1], file_input[i*4+2]]

        b_a_x, b_a_y = b_a.match(/.*X\+(\d*),\sY\+(\d*)/)[1, 2].map {|s| s.to_i}
        b_b_x, b_b_y = b_b.match(/.*X\+(\d*),\sY\+(\d*)/)[1, 2].map {|s| s.to_i}
        prize_x, prize_y = prize.match(/.*X=(\d*),\sY=(\d*)/)[1, 2].map {|s| s.to_i}

        best_push = nil
        for b_a_push in (1..(prize_x / b_a_x)).reverse_each
            b_a_x_score = b_a_push * b_a_x
            b_a_y_score = b_a_push * b_a_y
            diff = prize_x - b_a_x_score
            b_b_push = diff / b_b_x
            b_b_x_score = b_b_push * b_b_x
            b_b_y_score = b_b_push * b_b_y


            if b_a_x_score + b_b_x_score == prize_x && b_a_y_score + b_b_y_score == prize_y
                push = b_a_push * 3 + b_b_push
                best_push = push if best_push == nil || best_push > push
            end 
        end

        if best_push != nil
            sum += best_push
        end
    end

   
    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end


puts "Test file"
main("test", 480)
puts "Input file"
main("input")