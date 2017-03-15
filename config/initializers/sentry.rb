# set up some configuration to be used for error logging aka Raven Sentry
Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.environments = %w[development production]
end