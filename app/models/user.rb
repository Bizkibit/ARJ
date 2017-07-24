class User < ApplicationRecord
  has_secure_password

  has_many :organizations

  has_many :applications, dependent: :destroy
  has_many :memberships, through: :applications, source: :organization

  has_many :attendances
  has_many :attending_events, through: :attendances, source: :event

  has_many :reviews, dependent: :nullify

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, uniqueness: true, presence: true


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  before_validation :downcase_email

  mount_uploader :picture, PictureUploader
  
  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def downcase_email
    self.email&.downcase!
  end

  def downcase_username
    self.username&.downcase!
  end
end
