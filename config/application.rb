# frozen_string_literal: true

require File.expand_path('boot', __dir__)

# To remove DB, we should not require all of rails.
# require 'rails/all'

# active_record is what we're not going to use, so comment it 'just in case'
# require 'active_record/railtie'

# This is not loaded in rails/all but inside active_record so add it if
# you want your models to work as expected. 
require 'active_model/railtie'
# And then the rest.
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'active_job/railtie'
require 'action_cable/engine'
# require 'active_storage/engine'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'
require 'active_support/logger'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Core application class
class SlateServer::Application < Rails::Application
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
  # config.time_zone = 'Central Time (US & Canada)'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
  # config.i18n.default_locale = :de

  # Do not swallow errors in after_commit/after_rollback callbacks.
  # config.active_record.raise_in_transactional_callbacks = true

  config.eager_load_paths << Rails.root.join('lib')
  config.data = config_for(:data)

  config.logger = Logger.new(STDOUT)

  paths['build'] = 'build'
end
