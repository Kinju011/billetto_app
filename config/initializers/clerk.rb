Clerk.configure do |config|
  config.secret_key = ENV["CLERK_SECRET_KEY"] || (Rails.env.test? ? "sk_test_mock" : nil)
  config.publishable_key = ENV["CLERK_PUBLISHABLE_KEY"] || (Rails.env.test? ? "pk_test_mock" : nil)
end
