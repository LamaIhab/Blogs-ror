class Comment < ApplicationRecord
	#validation for creating comment
	validates :description,presence: true,length: {minimum: 2}

#relations for comment 
belongs_to :user
belongs_to :post
end
