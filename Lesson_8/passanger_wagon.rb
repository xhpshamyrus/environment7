class PassangerWagon < Wagon
  def initialize(number, total_volume)
    @type = :passanger
    super
  end

  def take_volume
    super(1)
  end
end
