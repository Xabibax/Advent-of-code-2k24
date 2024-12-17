module Direction
    N="^"
    E=">"
    S="v"
    W="<"  
end

def find_starting_point(file_input) 
    file_input.each_with_index do |line, i|
        line.each_with_index do |c, j|
            case c
            when Direction::N,Direction::E,Direction::S,Direction::W 
              return j,i
            end

        end           
    end  
end

def main(filename, result = nil)
    sum = 1

    file_input = File.read(filename).split.map {|s| s.split("")} 

    x, y = find_starting_point(file_input)

    while(x != 0 && x != file_input[0].length-1 && y != 0 && y != file_input.length-1) do
        c = file_input[y][x]      
        case c 
        when Direction::N
            if file_input[y-1][x] == '#'
                file_input[y][x] = Direction::E
            else
                file_input[y][x] = 'X'
                file_input[y-1][x] = c
            end
        when Direction::E
            if file_input[y][x+1] == '#'
                file_input[y][x] = Direction::S
            else
                file_input[y][x] = 'X'
                file_input[y][x+1] = c
            end
        when Direction::S
            if file_input[y+1][x] == '#'
                file_input[y][x] = Direction::W
            else
                file_input[y][x] = 'X'
                file_input[y+1][x] = c
            end
        when Direction::W
            if file_input[y][x-1] == '#'
                file_input[y][x] = Direction::N
            else
                file_input[y][x] = 'X'
                file_input[y][x-1] = c
            end

        end
        
        x, y = find_starting_point(file_input)
    end

    file_input.each do |line| 
        line.each { |c| sum += 1 if c == 'X' }
    end

    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end
puts "Test file"
main("test", 41)
puts "Input file"
main("input")