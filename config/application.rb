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

=begin
    config.autoload_paths += %W(
          #{ config.root }/app/controllers/concerns
          #{ config.root }/app/mailers/concerns
          #{ config.root }/app/models/concerns
          #{ config.root }/lib
    )
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.autoload_paths += [Rails.root.join('app', 'models','master')]
    config.i18n.default_locale = 'ja'
=end
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

    vendor_path = File.join(Rails.root, "vendor/assets/")
    Find.find(vendor_path).each do |f|
      if f.match(/^(.*)\.css/) || f.match(/^(.*)\.js/)
        config.assets.precompile << $1.sub(vendor_path, "")
      end
    end
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)


    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.generators do |g|
      g.template_engine :haml
      g.helper false
      g.stylesheets false
      g.javascripts false
      g.test_framework = "rspec"
      g.controller_specs = false
    end
  end

  # routing を外部ファイルに分割する
  #config.paths["config/routes"] << "config/routes/hoge.rb"
  #config.paths["config/routes"] << "config/routes/moge.rb"
end
