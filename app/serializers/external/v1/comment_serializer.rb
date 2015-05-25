class External::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :post_id
end
