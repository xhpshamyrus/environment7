class PassangerWagon < Wagon

  validate :number, :presence
  validate :number, :format, WAGON_FORMAT
  validate :total_volume, :volume

  def initialize(number, total_volume)
    @type = :passanger
    super
  end

  def take_volume
    super(1)
  end
end
