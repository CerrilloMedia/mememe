Rails.application.routes.draw do

devise_for :users

resources :posts do
  resources :comments
  get 'like', on: :member
end

root 'posts#index'

get 'users/:id' => 'users#show'

# passing a param to a GET request will allow us to pass in
get ':user_name',      to: 'profiles#show', as: :profile
get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
patch ':user_name/edit', to: 'profiles#update', as: :update_profile



end
