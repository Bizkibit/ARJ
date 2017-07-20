class Organization < ApplicationRecord

  belongs_to :user

  has_many :applications, dependent: :destroy
  has_many :applicants, through: :applications, source: :user

  has_many :events, dependent: :destroy

  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode

  include AASM

  aasm whiney_transitions: false do
    state :pending, intial: true
    state :approved, :rejected

    event :approve do
      transitions from: :pending, to: :approved
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end

  end


  def approved_applications
    self.applications.where(aasm_state: 'approved')
  end

end
