class PassWagon < Wagon
  attr_reader :occupied_volume

  def initialize(number, total_volume)
    @type = :passanger
    @number = number
    @occupied_volume = occupied_volume
    super
  end

  def take_volume
    super(1)
  end
end
