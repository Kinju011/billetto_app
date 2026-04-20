require 'rails_helper'

RSpec.describe Event, type: :model do
  it "is invalid without a title" do
    event = Event.new(title: nil)
    expect(event).not_to be_valid
  end

  it "is invalid without a date" do
    event = Event.new(date: nil)
    expect(event).not_to be_valid
  end

  it "is invalid without an external_id" do
    event = Event.new(external_id: nil)
    expect(event).not_to be_valid
  end

  it "is invalid with a duplicate external_id" do
    Event.create!(title: "Original", date: Time.now, external_id: "unique_123")
    event = Event.new(title: "Duplicate", date: Time.now, external_id: "unique_123")
    expect(event).not_to be_valid
  end
end
