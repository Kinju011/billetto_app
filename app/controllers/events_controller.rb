class EventsController < ApplicationController
  def index
    @events = Event.order(date: :asc)
    @event_store = Rails.configuration.event_store
  end
end
