class PassWagon < Wagon
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
