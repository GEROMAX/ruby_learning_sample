require 'delegate'

class DelegateTest
  def my_name
    "DelegateTest"
  end
end

class Gero < DelegateClass(DelegateTest)
#  def initialize(_delegate_est)
#    super
#  end

  def my_name
    super + " by GEROMAX"
  end
end

begin
  p Gero.new(DelegateTest.new).my_name
end
