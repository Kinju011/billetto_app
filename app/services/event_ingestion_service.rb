class EventIngestionService
  def initialize(api_service:)
    @api_service = api_service
  end

  def call
    events = @api_service.fetch_events

    events.each do |event_data|
      Event.find_or_initialize_by(external_id: event_data["id"]).tap do |event|
        event.title = event_data["title"]
        event.description = event_data["description"]
        event.date = event_data["start_time"]
        event.image_url = event_data["image"]

        event.save!
      end
    end
  end
end