require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Viethan
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Facebook bot files loading
    config.paths.add File.join('app', 'bot'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'bot', '*')]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Seoul'

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.i18n.load_path += Dir[Rails.root.join('locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :vi
    config.i18n.available_locales = [:en, :ko, :vi]
  end
end
