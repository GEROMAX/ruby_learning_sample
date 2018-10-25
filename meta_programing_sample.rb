def read_model(model_class, id)
  model_class.model_attrs.each_with_object({}) do |attr_name, attributes|
    value = nil
    case attr_name
    when :id
      value = id
    else
      value = "#{model_class.to_s.downcase}_#{attr_name.to_s}#{id}" if id
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

  def change_value?
    @@model_attrs.any? do |attr_name|
      !@attributes[attr_name].eql?(eval("@#{attr_name.to_s}"))
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

  tm = TestModel.new(id: 1)
  puts tm.name
  puts tm.value
  tm.name = "rename"
  puts tm.change_value?
  p tm

end
