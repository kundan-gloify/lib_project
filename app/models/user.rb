class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :date_of_birth, presence: true

  has_many :books
  # has_many :library, :through => :books

  enum role: [:admin, :author]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :author
  end
end
