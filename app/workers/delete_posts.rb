
require 'sidekiq-scheduler'

class DeletePosts
  include Sidekiq::Worker
# every sidekiq job has a perform method to run this when added to queue
	def perform
  	#deleting all posts with their comments according to schedule using sidekiq scheduler
  	Post.destroy_all
  end
end