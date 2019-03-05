class PassWagon < Wagon
  def initialize(number)
    @type = :passanger
    super(number)
  end
end
