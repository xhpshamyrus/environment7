class CargoTrain < Train

  validate :number, :validate_presence
  validate :number, :validate_format, NUMBER_FORMAT

  def initialize(number)
    super(number)
    @type = :cargo
  end
end
