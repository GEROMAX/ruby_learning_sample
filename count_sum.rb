def count_sum(value)
  num = value.to_i
  ans = 0
  num.times do |idx|
    ans += idx + 1
  end
  ans <= 0 ? "ERROR" : ans.to_s
end

begin
  puts "input!"
  value = gets.chomp!
  puts count_sum(value)
end