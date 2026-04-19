class VotesController < ApplicationController
  def create
    event_id = params[:event_id]
    type = params[:type]

    event_store = Rails.configuration.event_store
    stream_name = "event_#{event_id}"

    case type
    when "up"
      event_store.publish(EventUpvoted.new(data: { event_id: event_id }), stream_name: stream_name)
    when "down"
      event_store.publish(EventDownvoted.new(data: { event_id: event_id }), stream_name: stream_name)
    end

    @event = Event.find(event_id)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end
end
