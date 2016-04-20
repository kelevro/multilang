Multilang::Engine.routes.draw do
  resources :languages, only: [:index, :new, :destroy, :create, :edit, :update] do
    get :default, on: :member
    get :enable, on: :member
    get :disable, on: :member
  end

  resources :translations, only: [:index, :update] do
    patch :change_status, on: :member
    post :search, on: :collection
  end

  resources :translation_keys, only: [:create, :destroy]

  get 'export', to: 'export#run'
  get '/', to: 'languages#index', as: :root
end
