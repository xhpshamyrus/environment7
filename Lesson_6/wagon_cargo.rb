class CargoWagon < Wagon
  def initialize(number)
    @type = :cargo
    super(number)
  end
end
