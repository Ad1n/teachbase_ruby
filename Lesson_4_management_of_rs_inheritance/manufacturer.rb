module Manufacturer
  include Validation

  attr_reader :manufacturer

  def manufacturer=(manufacturer)
    @manufacturer = manufacturer
    raise 'Can not be empty !' if manufacturer.empty?
  end
end
