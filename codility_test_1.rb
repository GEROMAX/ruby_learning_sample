def solution(a)
  # write your code in Ruby 2.2
  return a[0] - a[1] if a.length.eql?(2)

  min_value, min_idx = find_min_and_idx(a, 0)

  max_diff = nil
  calc_diff = nil
  len = a.length
  (len - 1).times do |idx|
    a_parts = a[idx]
    b_parts = min_value
    if idx > min_idx
      min_value, min_idx = find_min_and_idx(a, idx)
      b_parts = min_value
    end
    calc_diff = a_parts - b_parts
    max_diff ||= calc_diff
    max_diff = calc_diff if max_diff < calc_diff
  end
  max_diff
end

def find_min_and_idx(arr, offset)
  min_value = arr[offset]
  min_idx = offset
  len = arr.length
  ((offset + 1)..(len - 1)).each do |idx|
    next if min_value < arr[idx]
    min_value = arr[idx]
    min_idx = idx
  end
  return min_value, min_idx
end


begin

  puts "--------------------"
  
  puts solution([1,2])

  puts "--------------------"
  
  puts solution([1,3,-3])

  puts "--------------------"

  puts solution([4,3,2,5,1,1])

  puts "--------------------"

  puts solution([1,0,-3])

  puts "--------------------"

  puts solution([0,3,2,5,1,1])





  puts "--------------------"

  puts solution([7, 3, 7, 3, 1, 3, 4, 1])

  puts "--------------------"

  puts solution([2,1,1,3,2,1,1,3])

  puts "--------------------"

  puts solution([7,5,2,7,2,7,4,7])


  puts solution([1])

end