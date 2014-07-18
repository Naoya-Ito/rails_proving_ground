# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
RailsProvingGround::Application.initialize!


RailsProvingGround::Application.configure do
  config.assets.precompile += %w(cosmo.css cosmo.js bunseki.js)
end

