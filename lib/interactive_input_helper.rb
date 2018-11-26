module InteractiveInputHelper
  def gets_line(message, pattern = nil)
    input_value = ""
    while input_value.empty?
      puts message
      input_value = STDIN.gets.chomp
      next unless pattern

      md = /#{pattern}/.match(input_value)
      input_value = (md ? md[0] : "")
    end
    input_value
  end

  def gets_lines(message)
    puts message
    input_values = []
    until (value = STDIN.gets.chomp).empty?
      input_values << value
    end
    input_values
  end
end
