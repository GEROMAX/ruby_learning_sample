# for i in 1..100 do
#   txt = ''
#   txt << 'Fizz' if (i % 3).eql?(0)
#   txt << 'Buzz' if (i % 5).eql?(0)
#   txt << i.to_s if txt.empty?
#   puts txt
# end
(1..100).to_a.reduce([]) do |result, i| 
  txt = ""
  txt << "Fizz" if (i % 3).eql?(0)
  txt << "Buzz" if (i % 5).eql?(0)
  txt << i.to_s if txt.empty?
  result << txt
end.tap {|ans| puts ans}
