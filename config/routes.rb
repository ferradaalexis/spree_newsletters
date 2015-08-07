Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  resources :newsletters, only: :create
end
