require 'logger'

#標準エラー出力
e_logger = Logger.new(STDERR)
#標準出力
i_logger = Logger.new(STDOUT)

class SomeInfo
  attr_accessor :name, :value
end

begin
  hs = Hash.new
  for i in 1..10
    si = SomeInfo.new
    si.name = i.to_s
    si.value = i * 10
    hs[si.name] = si
  end

  #ランダムで例外を発生させる
  effector = ((Random.new(Time.now.to_i).rand(10) % 2) == 0 ? '10' : '11')
  puts hs[effector].value  

rescue => exception
  e_logger.error(exception)
  exit
end

i_logger.info('process done.')
