def main(filename, result = nil)
    sum = 0

    file_input = File.read(filename).split("\n")

    antennas = {}
    antinodes = Set[]

    file_input.each_with_index do |line, y| 
        line.split("").each_with_index do |c, x|
            if (/[a-z]|[A-Z]|[0-9]/.match(c) != nil)
              if(antennas.key?(c))
                antennas[c] = antennas[c] + [[x,y]]
              else
                antennas[c] = [[x,y]]
              end
            end
        end
    end

    antennas.keys.each do |frequency| 
        antennas[frequency].each do |x,y|
            antennas[frequency].each do |other_x, other_y|
                next if([x,y] == [other_x, other_y])
                antinode = [x+x-other_x, y+y-other_y]
                antinodes.add(antinode)
            end
        end 
    end

    valid_antinodes = antinodes.select { |x, y| x>= 0 && x <= file_input[0].length-1 && y>=0 && y <= file_input.length-1 }
    sum = valid_antinodes.length()

    puts sum
    if result != nil then puts sum == result ? "Correct" : "Incorrect" end 
end
puts "Test file"
main("test", 14)
puts "Input file"
main("input")