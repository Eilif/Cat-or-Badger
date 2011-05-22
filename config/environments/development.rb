CatOrBadger::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  Paperclip.options[:command_path] = "/usr/bin/"

  PAPERCLIP_STORAGE_OPTIONS = {}

  #something devise needs me to insert, must change if I changed from localhost? though I don't know why I would do that.  also similar line in production that will have to change if I move off of heroku, more important to remember.
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  # config.action_mailer.raise_delivery_errors = false

  # should log errors in sending emails through devise but should not send me notice emails.  can get rid of these later and reactivate the one above if I don't like tutorial settings.
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default :charset => "utf-8"

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
end

