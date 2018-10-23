class TestModel
  # attr_accessorの後ろでメソッド定義するとメソッド定義で上書きされる
  attr_accessor :id, :name

  def id
    eval "@#{__method__} ||= 1"
  end

  # メソッド定義の後でattr_accessorするとattr_accessorで上書きされる
  # attr_accessor :id, :name
end

begin
  model = TestModel.new()
  p model.id
  model.id = 2
  p model.id
end
