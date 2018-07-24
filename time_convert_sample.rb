# rialsではTime型は非主流
require 'time'

value = Time.now

puts 'default  : ' + value.to_s
puts 'UTC      : ' + value.gmtime.to_s
puts 'ISO8601  : ' + Time.parse(value.ctime).iso8601
puts 'HH24MISS : ' + value.localtime.strftime("%Y/%m/%d %H:%M:%S")
