class Comment < ApplicationRecord
validates :description,presence: true,length: {minimum: 2}

belongs_to :user
belongs_to :post
end
