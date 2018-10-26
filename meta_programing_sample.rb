def read_model(model_class, id)
  model_class.model_attrs.each_with_object({}) do |attr_name, attributes|
    value = nil
    case attr_name
    when :id
      value = id
    else
      value = "#{model_class.to_s.downcase}_#{attr_name}#{id}" if id
    end
    attributes.store(attr_name, value)
  end
end

module ModelAttrDefine
  def attr_define(attr_name)
    class_eval <<-END_OF_DEF, __FILE__, __LINE__ + 1
      def #{attr_name}
        @#{attr_name} ||= attribute_value(:#{attr_name.to_sym})
      end
    END_OF_DEF
  end
end

class ModelBase
  # クラスメソッドからはクラスメソッドじゃないと呼べない
  extend ModelAttrDefine
  attr_accessor :id

  def self.attr_accessor(*vars)
    @@model_attrs ||= [:id]
    @@model_attrs.concat vars
    super
    @@model_attrs.map(&:to_s).each {|attr_name| attr_define(attr_name)}
  end

  def self.model_attrs
    @@model_attrs
  end

  def initialize(attributes = {})
    @attributes = attributes
    @id ||= @attributes[:id]
  end

  def load
    @attributes = read_model(self.class, @id)
    self
  end

  def change_value?
    @@model_attrs.any? do |attr_name|
      @attributes[attr_name] != eval("@#{attr_name}", binding, __FILE__, __LINE__)
    end
  end

  def attribute_value(attr_name)
    return @attributes[attr_name] if @attributes[attr_name]
    @attributes = read_model(self.class, @id)
    @attributes[attr_name]
  end
  private :attribute_value
end

class TestModel < ModelBase
  attr_accessor :name, :value

  def initialize(id)
    super(id)
  end
end

begin

  tm1 = TestModel.new(id: 1)
  puts tm1.name
  puts tm1.value
  # tm.name = "rename"
  puts tm1.change_value?
  p tm1

  tm2 = TestModel.new(id: 2).load
  p tm2

end
