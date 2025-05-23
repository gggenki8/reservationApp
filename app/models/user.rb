class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  validates :name, presence: true
  has_many :rooms, dependent: :destroy
  has_many :reservations

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true
end
