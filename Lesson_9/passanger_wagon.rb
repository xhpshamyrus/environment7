class PassangerWagon < Wagon

  validate :number, :presence
  validate :total_volume, :max_value, 99
  validate :number, :format, WAGON_FORMAT

  def initialize(number, total_volume)
    @type = :passanger
    super
  end

  def take_volume
    super(1)
  end
end
