require 'rails_helper'

RSpec.describe "Votes", type: :request do
  let(:event) { Event.create!(title: "Test Event", date: Time.now, external_id: "ext_123") }

  describe "POST /votes" do
    context "when user is not logged in" do
      it "redirects to the root path" do
        post votes_path(event_id: event.id, type: "up")
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("You must be logged in to perform this action.")
      end
    end

    context "when user is logged in" do
      let(:user_id) { "user_2026" }

      before do
        # Mock Clerk user verification in ApplicationController
        allow_any_instance_of(ApplicationController).to receive(:user_signed_in?).and_return(true)
        allow_any_instance_of(ApplicationController).to receive(:current_user_id).and_return(user_id)
      end

      it "successfully publishes an EventUpvoted event to RES" do
        event_store = Rails.configuration.event_store

        expect {
          post votes_path(event_id: event.id, type: "up")
        }.to change {
          event_store.read.stream("event_#{event.id}").to_a.count
        }.by(1)

        published_event = event_store.read.stream("event_#{event.id}").to_a.last
        expect(published_event).to be_an(EventUpvoted)
        expect(published_event.data[:user_id]).to eq(user_id)
      end

      it "prevents duplicate votes from the same user" do
        # First vote
        post votes_path(event_id: event.id, type: "up")

        # Second vote
        expect {
          post votes_path(event_id: event.id, type: "up")
        }.not_to change {
          Rails.configuration.event_store.read.stream("event_#{event.id}").to_a.count
        }

        expect(flash[:alert]).to eq("You have already voted on this event.")
      end
    end
  end
end
