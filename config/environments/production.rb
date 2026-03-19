Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.exceptions_app = routes
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.force_ssl = true
  config.log_level = :debug
  config.log_tags = [:request_id]
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtppro.zoho.com",
    port: 465,
    authentication: :plain,
    ssl: true,
    user_name: ENV["SMTP_USERNAME"],
    password: ENV["SMTP_PASSWORD"]
  }
  config.action_mailer.default_url_options = { host: ENV.fetch("APP_HOST", "councilvotetracker.ie"), protocol: "https" }
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.cache_store = :redis_cache_store

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
