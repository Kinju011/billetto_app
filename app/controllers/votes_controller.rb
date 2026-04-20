class VotesController < ApplicationController
  before_action :require_authentication!

  def create
    event_id = params[:event_id]
    type = params[:type]

    event_store = Rails.configuration.event_store
    stream_name = "event_#{event_id}"

    # Check if user already voted in this stream
    existing_events = event_store.read.stream(stream_name).to_a
    if existing_events.any? { |e| e.data[:user_id] == current_user_id }
      respond_to do |format|
        format.html { redirect_to root_path, alert: "You have already voted on this event." }
        format.turbo_stream do
          flash.now[:alert] = "You have already voted on this event."
          render turbo_stream: turbo_stream.append("flash", partial: "shared/flash", locals: { message: flash.now[:alert], type: "alert" })
        end
      end
      return
    end

    case type
    when "up"
      event_store.publish(
        EventUpvoted.new(data: { event_id: event_id, user_id: current_user_id }),
        stream_name: stream_name
      )
    when "down"
      event_store.publish(
        EventDownvoted.new(data: { event_id: event_id, user_id: current_user_id }),
        stream_name: stream_name
      )
    end

    @event = Event.find(event_id)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end
end
