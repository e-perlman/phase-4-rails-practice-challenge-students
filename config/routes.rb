Rails.application.routes.draw do
  
  resources :instructors, only:[:index, :create, :update, :destroy] do
    resources :students, only:[:create, :update]
  end
  resources :students, only:[:index,:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
