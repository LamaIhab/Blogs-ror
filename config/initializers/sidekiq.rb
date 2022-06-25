# if Rails.env.production?
#     redis_host = '127.0.0.1'
#     redis_port = 6379
#     redis_db = 1
#   else
  #   redis_host = <%= ENV['DB_NAME'] %>
  #   redis_port = Rails.env.REDIS_PORT
  #   redis_db =  Rails.env.REDIS_DB
  # # end

  #redis configuration for sidekiq
  
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://redis:6379/1') }
  end
  
  Sidekiq.configure_client do |config|
    config.redis = {  url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://redis:6379/1') }
  end