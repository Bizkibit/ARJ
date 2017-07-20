class Review < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  validates :user_id, uniqueness: {
    scope: :organization_id,
    message: "You have reviewed already!"
  }
  
end
