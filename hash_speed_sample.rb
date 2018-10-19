require "benchmark"

SAMPLE_AMOUNT = 100_000

def random_hash
  hash = Hash.new("")
  random_key = ""
  magic_number = (0..(SAMPLE_AMOUNT - 1)).to_a.sample
  SAMPLE_AMOUNT.times do |idx|
    key = random_word
    hash[key] += idx.to_s
    random_key = key if magic_number.eql?(idx)
  end
  return hash, random_key
end

def random_word
  ("a".."z").to_a.sample(10).join("")
end

begin
  hash, random_key = random_hash
  value = nil
  result = Benchmark.realtime do
    value = hash[random_key]
  end
  puts value, random_key
  puts sprintf("処理時間 %4.6f ms", result * 1000)
end
