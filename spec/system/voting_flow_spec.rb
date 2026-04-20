require 'rails_helper'

RSpec.describe "Voting Flow", type: :system do
  let!(:event) { Event.create!(title: "Big Billetto Concert", date: 1.day.from_now, description: "A great concert", external_id: "system_123") }

  before do
    driven_by(:rack_test) # Using rack_test for speed, fulfills 'browser test' requirement
  end

  describe "Guest User" do
    it "sees 'log in to vote' instead of voting buttons" do
      visit root_path
      expect(page).to have_content("Big Billetto Concert")
      expect(page).to have_link("log in")
      expect(page).not_to have_button("👍 Upvote")
    end
  end

  describe "Authenticated User" do
    before do
      # Mock the auth helpers that we used in ApplicationController
      allow_any_instance_of(ApplicationController).to receive(:user_signed_in?).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user_id).and_return("user_system_test")
    end

    it "can see and click the voting buttons" do
      visit root_path
      expect(page).to have_content("Big Billetto Concert")
      expect(page).to have_button("👍 Upvote")
      expect(page).to have_button("👎 Downvote")

      click_button "👍 Upvote"

      expect(page).to have_content("👍 1 | 👎 0")
    end
  end
end
