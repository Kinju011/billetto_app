class VoteGuard
  def self.already_voted?(event_id, user_id)
    stream = "event_#{event_id}"

    Rails.configuration.event_store
      .read
      .stream(stream)
      .to_a
      .any? { |e| e.data[:user_id] == user_id }
  end
end
