arr = Array.new()
arr << [3,4,4]
arr << [3,4,0]
arr << [3,3,5]
arr << [3,3,4]
arr << [3,3,2]

base = [3,3,5]

def compare_result(target, base)
  puts "if compare %s <=> %s, result = %s" % [target, base, ((target <=> base) < 1)]
end

arr.each do |target|
  compare_result(target, base)  
end
