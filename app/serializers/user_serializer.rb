class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :username, :picture

  has_many :organizations
  has_many :memberships

  class OrganizationSerializer < ActiveModel::Serializer
    attributes :id, :name, :website, :phone
  end

end
