class Event < ApplicationRecord
  has_many :associations
  has_many :users, through: :associations
  belongs_to :creator, class_name: :User, foreign_key: :creator_id

  validates :name, presence: true, length: { in: 1..30 }
  validates :description, length: { maximum: 500 }
  validates :location, length: { maximum: 100 }
  validates :date, :start_event, :end_event, presence: true
  validate :start_end_times

  private

  def start_end_times
    errors.add(:end_event, 'must be after start time') if end_event < start_event
  end
end
