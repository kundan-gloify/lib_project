class Book < ApplicationRecord
  belongs_to :library, optional: true
  belongs_to :user, optional: true

  
  validates :title, presence: true
  validates :published_at, presence: true
  validates :language, presence: true
  validates :user_id, presence: true
end
