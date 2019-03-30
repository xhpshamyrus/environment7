class PassangerTrain < Train

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number)
    @type = :passanger
  end
end
