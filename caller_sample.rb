def gero
  max
end

def max
  fire
end

def fire
  puts caller
end

class TestClass
  def call_start_method
    gero
  end
end

begin
  TestClass.new.call_start_method
end
