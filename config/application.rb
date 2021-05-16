require_relative 'boot'

require 'rails/all'
require 'csv'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QAKHADelivery
  class Application < Rails::Application
    config.load_defaults 6.0
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
    config.time_zone = 'Asia/Bangkok'
    config.active_record.default_timezone = :local
    config.active_job.queue_adapter = :sidekiq
    config.factory_bot.definition_file_paths = ["custom/factories"]
    Rails.application.config.session_store :active_record_store
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: :any
      end
    end
    config.cache_store = :redis_store, {
      host: "localhost",
      port: 6379,
      db: 0
    }, {
      expires_in: 90.minutes
    }
  end
end
