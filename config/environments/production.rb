Rails.application.configure do
  # Code is not reloaded between requests.
  config.cache_classes = true

  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = true
  config.assets.digest = true
  # when problems arise.
  config.log_level = :debug
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  ENV['PRO_URL'] = '2c18d257a5c2068fa3ced5570e0902a945b2b13885f419a6d61ab4e956eb2fc082c403f9a011067f3520329132c6b32925575681d7cf9153a3b37b1f018e8fe7'
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end
  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default :charset => "utf-8"
  config.action_mailer.default_url_options = { :host => 'https://heka-app.herokuapp.com' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { 
    address: 'smtp.gmail.com',
    port: 587, 
    domain: 'gmail.com', 
    user_name: 'amit.svarogt@gmail.com',
    password: 'svarogt@!@#$',
    authentication: 'plain', 
    enable_starttls_auto: true 
  }
  config.action_mailer.asset_host = 'https://heka-app.herokuapp.com'
end
# info@nytapp.com
# password: 101news#101
#    user_name: 'km.arti@mobiloittegroup.com',
#     password: 'mobiloittegroup11',