class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :website

  has_many :applications, dependent: :destroy
  has_many :applicants
  has_many :events, dependent: :destroy
  has_many :reviews, dependent: :destroy

end
