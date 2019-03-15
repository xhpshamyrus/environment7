class CargoWagon < Wagon
  attr_accessor :volume
  attr_reader :total_volume

  def initialize(number, total_volume)
    @type = :cargo
    @number = number
    @total_volume
    super
  end

  def take_a_volume
    @volume
  end
end
