class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  validates :title, :body, presence: true

  scope :new_first, -> { order("created_at DESC") }
  scope :published, -> { where(draft: false) }
end
