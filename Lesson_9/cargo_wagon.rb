class CargoWagon < Wagon

  validate :number, :validate_presence
  validate :total_volume, :validate_max_value, 99
  validate :number, :validate_format, WAGON_FORMAT

  def initialize(number, total_volume)
    @type = :cargo
    super
  end
end
