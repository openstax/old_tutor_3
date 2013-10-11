# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

Ost::Application.routes.draw do

  mount OpenStax::Connect::Engine, at: "/connect"
  mount FinePrint::Engine => "/fine_print"

  root to: "static_page#home"

  get "copyright" => "static_page#copyright"
  get "terms" => "static_page#terms"

  get "users/registration" 
  put "users/register"

  resources :users, only: [] do
    post 'become', on: :member
  end

  get "dashboard_page"      => "dashboard_page#index"
  get "course_catalog_page" => "course_catalog_page#index"

  namespace 'dev' do
    get "/", to: 'base#index'

    namespace 'users' do
      post 'search'
    end
  end

  namespace 'admin' do 

    get '/', to: 'base#index'

    put "cron",                         to: 'base#cron', :as => "cron"
    get "raise_security_transgression", to: 'base#raise_security_transgression'
    get "raise_record_not_found",       to: 'base#raise_record_not_found'
    get "raise_routing_error",          to: 'base#raise_routing_error'
    get "raise_unknown_controller",     to: 'base#raise_unknown_controller'
    get "raise_unknown_action",         to: 'base#raise_unknown_action'
    get "raise_missing_template",       to: 'base#raise_missing_template'
    get "raise_not_yet_implemented",    to: 'base#raise_not_yet_implemented'
    get "raise_illegal_argument",       to: 'base#raise_illegal_argument'

    namespace 'users' do
      post 'search'
    end
  end

end
