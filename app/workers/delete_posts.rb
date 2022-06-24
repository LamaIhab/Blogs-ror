
require 'sidekiq-scheduler'

class DeletePosts
  include Sidekiq::Worker
# every sidekiq job has a perform method to run this when added to queue
  def perform
  	Post.destroy_all
  end
end