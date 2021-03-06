require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jmcleaning
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # document.policy.allowedFeatures().sort().join(" 'none'; ") + " 'none'";
    config.action_dispatch.default_headers.merge!(
      'X-Frame-Options' => 'DENY',
      'Feature-Policy' => "accelerometer 'none'; ambient-light-sensor 'none'; autoplay 'none'; "\
       "camera 'none'; encrypted-media 'none'; fullscreen 'none'; geolocation 'none'; "\
       "gyroscope 'none'; magnetometer 'none'; "\
       "microphone 'none'; midi 'none'; payment 'none'; picture-in-picture 'none'; "\
       "speaker 'none'; sync-xhr 'none'; usb 'none'; "\
       "vr 'none'")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
