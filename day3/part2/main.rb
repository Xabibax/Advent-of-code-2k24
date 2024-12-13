sum = 0 
calculate = true
File.foreach("input") { |line| 
    line.scan(/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/) { |inst| 
        if /do\(\)|don't\(\)/.match(inst)
            calculate = /do\(\)/.match(inst)
            next
        end
        if !calculate then next end
        n = inst.scan(/\d{1,3}/)
        p = n[0].to_i * n[1].to_i
        sum += p
    }
}
puts sum