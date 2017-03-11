Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'users/users#index'

  devise_for :admins,
    :skip => [:confirmations, :registrations],
    :controllers => {
      :sessions => "admins/devise/sessions",
      :passwords => "admins/devise/passwords"
    },
    :path_names => { :sign_in => "login", :sign_out => "logout" },
    :module => "admins"

  devise_for :users,
    :controllers => {
      :sessions => "users/devise/sessions",
      :registrations => "users/devise/registrations",
      :passwords => "users/devise/passwords"
    },
    :path_names => {
      :sign_in => "login",
      :sign_out => "logout",
      :sign_up => "signup"
    }

  resource :user, only: [], :controller => "users/users" do
    get  "profile"
    put  "update"
    get  "inbox"
    get  "sentbox"
    put  "toggle_activation"
  end

  resource :admin, only: [], :controller => "admins/admins" do
    get  "profile"
    put  "update"
    get  "inbox"
    get  "sentbox"
    get  "students"
    get  "show_students", :as => 'show_active_students'
  end

  # resources :announcements, except: [:show]
  resources :units, only: [:index]

  resources :course_modules, except: [:destroy] do
    member do
      get  "quizz"             => "quizzes#show"
      post "quizz/submit"      => "quizzes#submit"
      get  "quizz/certificate" => "quizzes#certificate"
      get  "quizz/certificate_pdf_preview" => "quizzes#certificate_pdf_preview"
    end
  end

  resources :course_videos, only: [:create, :update, :edit, :new]
  resources :supporting_materials, only: [:create, :update, :edit, :new]

  resources :conversations, only: [:show, :new], param: :slug

  put "/mark_read" => "conversations#mark_read", constraints: { :format => :json }

  resources :messages, only: [:create]

  post "/make_payment" => "users/users#charge"

end
