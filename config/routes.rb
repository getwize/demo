Rails.application.routes.draw do
 

  get 'student_plans/new'

  resources :students
  resources :charges
  resources :subscriptions
  resources :student_plans
  resources :billings
  resources :student_charges
  resources :student_subscriptions
  resources :student_subscription_discounts
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" ,:omniauth_callbacks => "omniauth_callbacks"}

  get 'owner' => 'students#owner'

  get 'pages/home'

  get 'pages/about'

  get 'pages/contact'

  get 'pages/blog'

  root 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
