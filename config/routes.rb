# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

Ost::Application.routes.draw do

  mount OpenStax::Connect::Engine, at: "/connect"
  mount FinePrint::Engine => "/fine_print"

  root :to => "static_page#home"

  get "copyright" => "static_page#copyright"
  get "terms" => "static_page#terms"

  get "users/registration" 
  put "users/register"

  get "dashboard_page"      => "dashboard_page#index"
  get "course_catalog_page" => "course_catalog_page#index"

  get "admin", :to => 'admin#index'
  put "admin/cron", :to => 'admin#cron', :as => "cron"
  get "admin/raise_security_transgression", :to => 'admin#raise_security_transgression'
  get "admin/raise_record_not_found",       :to => 'admin#raise_record_not_found'
  get "admin/raise_routing_error",          :to => 'admin#raise_routing_error'
  get "admin/raise_unknown_controller",     :to => 'admin#raise_unknown_controller'
  get "admin/raise_unknown_action",         :to => 'admin#raise_unknown_action'
  get "admin/raise_missing_template",       :to => 'admin#raise_missing_template'
  get "admin/raise_not_yet_implemented",    :to => 'admin#raise_not_yet_implemented'
  get "admin/raise_illegal_argument",       :to => 'admin#raise_illegal_argument'

  namespace 'dev' do
    get "/", to: 'base#index'
  end

end
