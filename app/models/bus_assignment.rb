class BusAssignment
  include ActiveModel::SerializerSupport

  attr_accessor :BusNumber,
                :StudentNo,
                :parentfirstname,
                :parentlastname,
                :studentfirstname,
                :studentlastname,
                :days

  alias :bus_number :BusNumber
  alias :student_number :StudentNo
  alias :parent_first_name :parentfirstname
  alias :parent_last_name :parentlastname
  alias :student_first_name :studentfirstname
  alias :student_last_name :studentlastname

  delegate :longitude, :latitude, :last_updated_at, to: :location

  def initialize(attributes)
    attributes.each do |attr, value|
      send("#{attr}=", value) if respond_to?(attr)
    end
  end

  def student_name
    "#{student_first_name} #{student_last_name}"
  end

  def location
    @location ||= Zonar.bus_location(bus_number)
  end
end
