class VotesController < ApplicationController
  before_action :require_authentication!

  def create
    event_id = params[:event_id]
    type = params[:type]

    return head :bad_request unless %w[up down].include?(type)

    if VoteGuard.already_voted?(event_id, current_user_id)
      respond_to do |format|
        format.html { redirect_to root_path, alert: "You have already voted on this event." }
        format.turbo_stream do
          flash.now[:alert] = "You have already voted on this event."
          render turbo_stream: turbo_stream.append(
            "flash",
            partial: "shared/flash",
            locals: { message: flash.now[:alert], type: "alert" }
          )
        end
      end
      return
    end

    event_store = Rails.configuration.event_store
    stream_name = "event_#{event_id}"

    event_class = type == "up" ? EventUpvoted : EventDownvoted

    event_store.publish(
      event_class.new(data: { event_id: event_id, user_id: current_user_id }),
      stream_name: stream_name
    )

    @event = Event.find(event_id)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end
end
