class Event < ApplicationRecord
  belongs_to :organization

  has_many :attendances
  has_many :attendees, through: :attendances, source: :user

  def spots_left
    spots - attendees.count
  end

end
