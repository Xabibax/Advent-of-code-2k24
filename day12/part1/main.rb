class Node
    attr_accessor :x, :y
    def initialize(x, y)
        @x = x
        @y = y
    end

    def get_neighbours(file_input)
        neigbours = []
        neigbours.push(Node.new(x-1, y)) if x > 0
        neigbours.push(Node.new(x+1, y)) if x < file_input[0].length-1
        neigbours.push(Node.new(x, y-1)) if y > 0
        neigbours.push(Node.new(x, y+1)) if y < file_input.length-1

        return neigbours.select { |n| file_input[n.y][n.x] == file_input[y][x] }
    end

    def get_area(file_input, visited = {})
        visited[[x, y]] = self
        neighbours = get_neighbours(file_input).select { |n| visited[[n.x, n.y]] == nil  }
        if neighbours.empty? 
            return visited
        end
        neighbours.each { |n| visited[[n.x, n.y]] = n }
        return neighbours.map { |n| n.get_area(file_input, visited)  }.reduce({}) { |a,b| a.merge(b) }
    end
end

def calc_perimeter(file_input, area)
    sum = 0
    area.each do |n|
        l = file_input[n.y][n.x]
        if n.x == 0 || file_input[n.y][n.x-1] != l
            sum += 1
        end
        if n.x == file_input[0].length-1 || file_input[n.y][n.x+1] != l
            sum += 1
        end
        if n.y == 0 || file_input[n.y-1][n.x] != l
            sum += 1
        end
        if n.y == file_input.length-1 || file_input[n.y+1][n.x] != l
            sum += 1
        end
    end
    return sum    
end

def find_first_area_character(file_input)
    file_input.each_with_index do |line, y|
        line.each_with_index do |c, x|
            return Node.new(x,y) if c != '.'
        end
    end  
    return nil
end

def main(filename, result = nil)
    sum = 0

    file_input = File.read(filename).split.map { |line| line.split("") }

    c = find_first_area_character(file_input)
    while c != nil
        area = c.get_area(file_input).values
        sum += area.length * calc_perimeter(file_input, area)
        area.each do |n|
            file_input[n.y][n.x] = '.'  
        end
        c = find_first_area_character(file_input)
    end
   
    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end


puts "Test file"
main("test", 140)
puts "Test2 file"
main("test2", 772)
puts "Test3 file"
main("test3", 1930)
puts "Input file"
main("input")