class Post < ApplicationRecord
	#validations for creating post
	validates :title,presence: true,length: {minimum: 2}
	validates :body,presence: true,length: {minimum: 2}
	validates :tags,presence: true

#relations for post
belongs_to :user
has_many :comments, dependent: :delete_all

end
