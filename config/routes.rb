Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'static#home'
  get '/how-it-works' => 'static#how_it_works'
  get '/about' => 'static#about'

  resources :users, only: [:show, :edit, :update]
  resources :admins, only: [:show]
  post 'admins/:id/invite_arbitrator' => 'admins#invite_arbitrator', as: 'admin_invite_arbitrator'
  resources :disputes do 
    resources :dispute_documents, only: [:index, :create, :show], as: 'documents'
    resource :survey, only: [:show] do
      post 'votes' => 'votes#create'
      patch 'votes' => 'votes#edit'
    end
  end
end