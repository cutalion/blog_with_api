class Internal::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :draft
  has_many :comments
end
