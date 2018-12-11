def gero
  puts "#{__method__},#{__callee__}"
end
alias :max :gero

begin
  gero
  max
end
