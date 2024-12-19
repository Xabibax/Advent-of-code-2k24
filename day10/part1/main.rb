def find_starting_point(file_input)
    starting_points = []
    file_input.each_with_index do |line, y|
        line.each_with_index do |i, x|
            starting_points.push([x,y]) if (i == 0)
        end  
    end  
    return starting_points
end

class Node
    attr_accessor :level, :x, :y
    def initialize(x, y, level)
        @x = x
        @y = y
        @level = level
    end
end

def get_neighbours(file_input, x, y)
    neighbours = []
    neighbours.push(Node.new(x-1, y, file_input[y][x-1])) if x > 0
    neighbours.push(Node.new(x+1, y, file_input[y][x+1])) if x < file_input[0].length() - 1
    neighbours.push(Node.new(x, y-1, file_input[y-1][x])) if y > 0
    neighbours.push(Node.new(x, y+1, file_input[y+1][x])) if y < file_input.length() - 1
    return neighbours.select { |n| n.level == file_input[y][x] + 1}
end


def get_trailheads(file_input, x, y, visited)
    level = file_input[y][x]
    if level == 9
        if visited.include?([x,y])
            return 0
        end
        visited.add([x,y])
        return 1
    end
    neighbours = get_neighbours(file_input, x, y)
    if neighbours.empty?
        return 0  
    end
    return neighbours.map { |neighbour| get_trailheads(file_input, neighbour.x, neighbour.y, visited) }.sum

end

def main(filename, result = nil)
    sum = 0

    file_input = File.read(filename).split.map { |line| line.split("").map { |s| s.to_i }  }
    starting_points = find_starting_point(file_input)
    starting_points.each do |starting_point|
        x, y = [starting_point[0], starting_point[1]]
        trailheads = get_trailheads(file_input, x, y, Set[])
        sum += trailheads
    end

    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end


puts "Test file"
main("test", 1)
puts "Test file 2"
main("test2", 36)
puts "Input file"
main("input")