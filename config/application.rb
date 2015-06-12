require File.expand_path('../boot', __FILE__)

# DBを使わないのでコメントアウト
#require 'rails/all'
#require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module RailsProvingGround
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # compile
    config.assets.precompile += %w( impress.js impress.css )

    require "find"
    js_path = File.join(Rails.root, "app/assets/javascripts/")
    Find.find(js_path).each do |f|
      if f.match(/^(.*)\.coffee$/)
        config.assets.precompile << $1.sub(js_path, "")
      end
    end

    css_path = File.join(Rails.root, "app/assets/stylesheets/")
    Find.find(css_path).each do |f|
      if f.match(/^(.*)\.scss$/) || f.match(/^(.*)\.sass$/)
        config.assets.precompile << $1.sub(css_path, "")
      end
    end

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.generators do |g|
      g.helper false
      g.stylesheets false
      g.javascripts false
    end
  end
end
