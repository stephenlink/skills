Rails.application.routes.draw do
  get 'profile/show'

  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'

  #resources :profiles
  resources :posts do
    member do
      get 'like'
    end
  end
  get ':user_name', to: 'profile#show', as: :profile
  get ':user_name/edit', to: 'profile#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profile#update', as: :update_profile

  get ':user_name/post', to: 'profile#new', as: :recommend_post
  post ':user_name/post', to: 'profile#build', as: :recommend_build

end
