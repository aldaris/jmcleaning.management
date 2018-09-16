require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jmcleaning
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.autoload_paths += %W(#{config.root}/lib)

    config.action_dispatch.default_headers.merge!({
      "X-Frame-Options" => "DENY",
      "Feature-Policy" => "accelerometer 'none'; ambient-light-sensor 'none'; animations 'none'; autoplay 'none'; "\
       "camera 'none'; cookie 'none'; document-stream-insertion 'none'; domain 'none'; encrypted-media 'none'; "\
       "fullscreen 'none'; geolocation 'none'; gyroscope 'none'; image-compression 'none'; "\
       "legacy-image-formats 'none'; magnetometer 'none'; max-downscaling-image 'none'; microphone 'none'; "\
       "midi 'none'; payment 'none'; picture-in-picture 'none'; speaker 'none'; sync-script 'none'; "\
       "sync-xhr 'none'; unsized-media 'none'; usb 'none'; vertical-scroll 'none'; vr 'none'"})

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
