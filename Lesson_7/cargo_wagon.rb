class CargoWagon < Wagon
  def initialize(number, total_volume)
    @type = :cargo
    super
  end
end
