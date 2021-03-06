Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'static#home'

  resources :users, only: [:show, :edit, :update]
  resources :admins, only: [:show]
  post 'admins/:id/invite_arbitrator' => 'admins#invite_arbitrator', as: 'admin_invite_arbitrator'
  resources :disputes do 
    resources :dispute_documents, only: [:index, :create, :show], as: 'documents'
  end
end
