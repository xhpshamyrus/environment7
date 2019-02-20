class CargoWagon < Wagon
  def initialize(number)
    @type = :cargo
    @number = number
  end
end
