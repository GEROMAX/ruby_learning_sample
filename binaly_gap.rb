def scan_input_value
  puts "input!"
  gets.chomp!
end

def max_gap_length(value)
  val = sprintf("%b", value.to_i)
  max_len = 0
  while val
    md = /(?<zero_str>10+1)/.match(val)
    break unless md
    gap_len = md[1].length - 2
    max_len = gap_len if max_len < gap_len
    val.sub!(md[1][0..-2], "")
  end
  max_len
end

begin
  # value = scan_input_value
  # puts max_gap_length(value)

  100.times do |num|
    puts sprintf("%b", num)
    puts max_gap_length(num)
    puts ""
  end
end