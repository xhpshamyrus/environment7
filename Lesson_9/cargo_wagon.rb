class CargoWagon < Wagon

  validate :number, :validate_presence
  validate :total_volume, :max_value
  validate :number, :validate_format, WAGON_FORMAT

  def initialize(number, total_volume)
    @type = :cargo
    super
  end
end
