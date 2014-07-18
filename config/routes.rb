RailsProvingGround::Application.routes.draw do

  root :to => 'roots#index'

  get "bunseki" => "roots#bunseki"

end
