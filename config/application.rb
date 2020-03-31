require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Todo
  class Application < Rails::Application
    config.load_defaults 6.0
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :delete]
      end
    end

  end
end
