class User < ApplicationRecord

validates :email, email: true,uniqueness: true,presence: true
validates :name,presence: true,length: {minimum: 2}
validates :image,presence: true
validates :password,presence: true,length: {minimum: 6}


has_many :posts ,dependent: :delete_all
has_many :comments, dependent: :delete_all
end
