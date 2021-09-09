class Library < ApplicationRecord
  # belongs_to :user
  has_many :books, dependent: :destroy
	has_many :users, :through => :books
	
	validates :name, presence: true
end
