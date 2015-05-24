RailsProvingGround::Application.routes.draw do

  root          to: "roots#index"
  get :bunseki, to: "roots#bunseki", as: "bunseki"
  get :study,   to: "roots#study",   as: "study"
  get :work,    to: "roots#work",    as: "work"

end
