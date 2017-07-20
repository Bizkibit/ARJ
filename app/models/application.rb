class Application < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  validates :user_id, uniqueness: {
    scope: :organization_id,
    message: "You have applied already!"
  }

  include AASM

  aasm whiney_transitions: false do
    state :pending, intial: true
    state :approved, :rejected, :enrolled, :waitlisted

    event :approve do
      transitions from: :pending, to: :approved
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end

    event :enroll do
      transitions from: :approved, to: :enrolled
    end

    event :waitlist do
      transitions from: :approved, to: :waitlisted
    end

    event :available do
      transitions from: :waitlisted, to: :enrolled
    end

  end
end
