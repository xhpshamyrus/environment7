class PassangerWagon < Wagon

  validate :number, :validate_presence
  validate :total_volume, :validate_max_value, 99
  validate :number, :validate_format, WAGON_FORMAT

  def initialize(number, total_volume)
    @type = :passanger
    super
  end

  def take_volume
    super(1)
  end
end
