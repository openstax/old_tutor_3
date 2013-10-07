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

end
