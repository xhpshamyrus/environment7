class PassangerTrain < Train
  attr_reader :type
def initialize(number)
  super(number)
  @type = :passanger
end

end
