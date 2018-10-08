# 数列内の要素のうち、すべての要素を含む最短の数列長を求めるやつ

def solution(a)
  # write your code in Ruby 2.2
  place_list = {}
  a.each {|place| place_list[place] = 0 }

  array_len = a.length
  dream_min = place_list.keys.length
  return dream_min if array_len.eql?(dream_min)

  (dream_min..(array_len - 1)).each do |vacancy_range|
    (array_len - vacancy_range).times do |idx|
      list = place_list.dup
      a.slice(idx, vacancy_range).each {|place| list[place] += 1 }
      return vacancy_range unless list.values.include?(0)
    end
  end
  array_len
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

  puts "--------------------"

  puts solution([1])

end