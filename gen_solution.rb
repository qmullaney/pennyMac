def find_min_spread(file, subject_name, min_name, max_name)

    min_spread_info = {min_spread: Float::INFINITY}

    min_index = nil
    max_index = nil
    subject_index = nil

    File.foreach(file) do |line|

        if !min_index && line.include?(min_name)

            min_index = line.index(min_name)
            max_index = line.index(max_name)
            subject_index = line.index(subject_name)
            
        elsif min_index && line.length >= min_index && line.length >= max_index

            min_num = line[min_index, 3].to_i
            max_num = line[max_index, 3].to_i

            min_spread = (min_num - max_num).abs()

            if min_spread < min_spread_info[:min_spread] && min_num != 0 && max_num != 0

                min_spread_info[:min_spread] = min_spread
                min_spread_info[:min_num] = min_num
                min_spread_info[:max_num] = max_num

                # find name of smallest spread yet
                subject_name = line[subject_index]

                line[(subject_index+1)..].each_char do |el|
                    break if el == " "
                    subject_name += el
                end

                min_spread_info[:subject_name] = subject_name

            end
        end
    end

    s = min_spread_info[:subject_name]
    ms = min_spread_info[:min_spread]
    fg = min_spread_info[:min_num]
    ag = min_spread_info[:max_num]

    File.open("output.txt", "a") do |f|
        f.write("Row: #{s}, #{ms} Difference, Max: #{fg}, Min: #{ag}\n")
        f.write("\n")
        f.write("\n")
    end


    puts "Row: #{s}, #{ms} Difference, Max: #{fg}, Min: #{ag}\n"
end

find_min_spread('soccer.dat', 'Team', 'F', 'A')
find_min_spread('w_data.dat', 'Dy', 'MxT', 'MnT')