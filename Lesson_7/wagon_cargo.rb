class CargoWagon < Wagon
  def initialize(number, total_volume)
    @type = :cargo
    @number = number
    super
  end
end
