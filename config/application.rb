require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module Apollo
  class Application < Rails::Application
    # setup to handle exceptions
    config.exceptions_app = self.routes

    if Rails.env.development?
      begin
        YAML.load(File.read('config/spotify.yml')).each do |key, value|
          ENV[key] = value
        end
      rescue
        raise "You need to add config/spotify.yml"
      end
    end

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end

RSpotify::authenticate(ENV['client_id'], ENV['client_secret'])
