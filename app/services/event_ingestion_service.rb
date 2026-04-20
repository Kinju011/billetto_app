class EventIngestionService
  def initialize(api_service:)
    @api_service = api_service
  end

  def call
    response = @api_service.fetch_events
    events = response["data"]

    events.each do |event_data|
      mapped = map_event(event_data)

      Event.find_or_initialize_by(external_id: mapped[:external_id]).tap do |event|
        event.assign_attributes(mapped)
        event.save!
      end
    end
  end

  private

  def map_event(data)
    {
      external_id: data["id"],
      title: data["title"],
      description: data["description"],
      date: data["startdate"],
      image_url: data["image_link"]
    }
  end
end
