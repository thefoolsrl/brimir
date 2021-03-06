require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Brimir
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.autoload_paths << Rails.root.join('app/services')
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Change this to :ldap_authenticatable to use ldap
    config.devise_authentication_strategy = :database_authenticatable
    config.i18n.default_locale = :en
    config.i18n.available_locales = %i(ar de en es fa fi fr-CA fr-FR nb nl pt-BR ru uk zh-CN)
    config.i18n.fallbacks = %i(en)
    config.action_dispatch.default_headers = {
      'Referrer-Policy' => 'No-referrer-when-downgrade',
      'X-XSS-Protection' => '1; mode=block',
      'X-Frame-Options' => 'DENY',
      'X-Content-Type-Options' => 'nosniff',
      'Cache-Control' => 'no-cache, max-age=0',
      'Expires' => '0',
      'Strict-Transport-Security' => 'max-age=15768000; preload'
    }
  end
end
