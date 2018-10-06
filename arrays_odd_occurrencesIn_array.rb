def find_no_duplication(arr)
  hs = Hash.new(0)
  arr.each do |value|
    hs[value]+=1
  end
  hs.select {|key, value| value.eql?(1) }.keys[0]
end

def cool_anser(arr)
  ans = 0
  arr.each do |value|
    ans ^= value
  end
  ans
end

begin
  # puts find_no_duplication([9, 3, 9, 3, 9, 7, 9])
  puts cool_anser([9, 3, 9, 3, 9, 7, 9, 7, 1])
end