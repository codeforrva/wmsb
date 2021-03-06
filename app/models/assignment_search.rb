class AssignmentSearch
  extend ActiveModel::Translation

  class_attribute :connection, instance_writer: false
  self.connection = Faraday.new(ENV['BPS_API'])

  attr_reader :assignments, :errors

  def self.find(aspen_contact_id)
    new(aspen_contact_id).find
  end

  def initialize(aspen_contact_id)
    @aspen_contact_id = aspen_contact_id
    @errors           = ActiveModel::Errors.new(self)
  end

  def find
    response_body =  Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      response = connection.get(
        '/bpswstr/Connect.svc/bus_assignments',
        aspen_contact_id: @aspen_contact_id,
        TripFlag: trip_flag,
        ForThisDate: current_date,
        UserName: username,
        Password: password
      )

      if !response.success?
        @errors.add(:assignments, :missing)
      end

      response.success? ? response.body : nil
    end

    if response_body.present?
      assignments = JSON.parse(response_body)
      @assignments = assignments.map do |assignment|
        BusAssignment.new(assignment, trip_flag)
      end
    else
      @assignments = []
    end

    return self
  end

  def assignments_with_gps_data
    assignments.select(&:gps_available?)
  end

  def assignments_without_gps_data
    assignments.reject(&:gps_available?)
  end

  alias :read_attribute_for_validation :send

  private

  def cache_key
    "bps.assignments.#{@aspen_contact_id}.#{trip_flag}"
  end

  def trip_flag
    time_of_request.hour >= 11 ? 'departure' : 'arrival'
  end

  def current_date
    time_of_request.strftime('%D')
  end

  def time_of_request
    @time_of_request ||= Time.zone.now
  end

  def username
    ENV['BPS_USERNAME']
  end

  def password
    ENV['BPS_PASSWORD']
  end
end
