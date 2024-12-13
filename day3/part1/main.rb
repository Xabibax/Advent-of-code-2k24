sum = 0
File.foreach("input") { |line| 
    line.scan(/mul\(\d{1,3},\d{1,3}\)/) { |mul| 
        n = mul.scan(/\d{1,3}/)
        p = n[0].to_i * n[1].to_i
        puts p
        sum += p
    }
}
puts sum