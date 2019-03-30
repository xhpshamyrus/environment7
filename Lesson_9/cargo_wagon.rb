class CargoWagon < Wagon

  validate :number, :presence
  validate :number, :format, WAGON_FORMAT
  validate :total_volume, :volume

  def initialize(number, total_volume)
    @type = :cargo
    super
  end
end
