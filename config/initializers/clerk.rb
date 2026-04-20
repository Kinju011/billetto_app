Clerk.configure do |config|
  config.secret_key = ENV["CLERK_SECRET_KEY"]
  config.publishable_key = ENV["CLERK_PUBLISHABLE_KEY"]
end
