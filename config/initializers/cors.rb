Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://web.chair-app.com', 'localhost:8000'
    resource '*',
             headers: :any,
             expose: %w[access-token expiry token-type uid client Content-Type],
             methods: %i[get post put patch delete options head],
             credentials: true
  end
end
