module Helper
  #モジュールに特異メソッドを定義
  module_function

  def create_list
    # list = Array.new
    # for count in 1..10 do
    #   list << ListItem.new("Item%#02d" % [count], count)
    # end
    # (1..10).to_a.each do |count| list << ListItem.new("Item%#02d" % [count], count) end
    # list
    (1..10).to_a.reduce([]) do |list, count| list << ListItem.new("Item%#02d" % [count], count) end
  end
end

class ListItem
  #プロパティと同義
  attr_accessor :name, :value

  #コンストラクタ
  def initialize(name, value)
    @name = name
    @value = value
  end
end

class TestClass
  #クラス変数
  @@list = nil

  #クラスメソッド
  def self.list=(value)
    @@list = value
  end

  #インスタンスメソッド
  def to_s
    @@list.to_s
  end
end

TestClass.list = Helper.create_list
tc = TestClass.new
puts tc.to_s.split(">,")
