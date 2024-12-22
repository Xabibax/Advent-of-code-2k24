def main(filename, width, height, result = nil)
    sum = 0

    file_input = File.read(filename).split("\n")

    room = {}

    file_input.each_with_index do |line, i|
        p_x, p_y, v_x, v_y = line.match(/p=(-?\d*),(-?\d*)\s*v=(-?\d*),(-?\d*)/)[1..4].map { |s| s.to_i }

        f_x = (p_x + v_x * 100) % width
        f_y = (p_y + v_y * 100) % height
    
        pos = room[[f_x,f_y]]
        room[[f_x,f_y]] = pos == nil ? 1 : pos + 1
    end

    nw = room.keys.select { |x,y| x < width/2 && y < height/2}.map { |x,y| room[[x,y]]}.sum
    ne = room.keys.select { |x,y| x > width/2 && y < height/2}.map { |x,y| room[[x,y]]}.sum
    se = room.keys.select { |x,y| x > width/2 && y > height/2}.map { |x,y| room[[x,y]]}.sum
    sw = room.keys.select { |x,y| x < width/2 && y > height/2}.map { |x,y| room[[x,y]]}.sum
    
    sum += [ne, se, sw].reduce(nw) { |a,b| a*b }

    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end


puts "Test file"
main("test", 11, 7, 12)
puts "Input file"
main("input", 101, 103)