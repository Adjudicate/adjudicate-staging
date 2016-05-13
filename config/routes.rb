Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  devise_scope :user do
    get "/signin" => "devise/sessions#new"
    get "/signup" => "devise/registrations#new"
  end

  root 'static#home'
  get '/how-it-works' => 'static#how_it_works'
  get '/about' => 'static#about'
  get '/terms' => 'static#terms'
  get '/rules' => 'static#rules'


  resources :users, only: [:show, :edit, :update] do 
    post 'invite_arbitrator' => 'users#invite_arbitrator'
    post 'inform_defendant' => 'users#inform_defendant'
    resources :billing, only: [:show]
  end
  resources :admins, only: [:show]
  post 'admins/:id/invite_arbitrator' => 'admins#invite_arbitrator', as: 'admin_invite_arbitrator'
  resources :disputes do
    get 'edit_admin' => 'disputes#edit_admin'
    patch 'update_admin' => 'disputes#update_admin'
    resources :dispute_documents, only: [:index, :create, :show], as: 'documents'
    get 'vote' => 'disputes#vote_show'

    resource :survey, only: [:show] do
      post 'votes' => 'votes#create'
      patch 'votes' => 'votes#edit'
    end

    resources :vote_submitted, only: [:index]
    resources :comments, only: [:create]
  end
end