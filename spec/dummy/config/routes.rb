Rails.application.routes.draw do

  get 'home/index'

  mount Multilang::Engine => "/multilang"

  root to: 'home#index'
end
