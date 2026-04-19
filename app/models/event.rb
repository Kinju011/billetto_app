class Event < ApplicationRecord
	validates :title, presence: true
  validates :date, presence: true
  validates :external_id, presence: true, uniqueness: true
end
