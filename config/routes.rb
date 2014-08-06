# This file defines Rails' routing table. In any web application, the
# "routing table" maps incoming to requests to code to call.
#
# In Rails, the routing table is all in one place (here) and the code to call
# lives in the instance methods of various controllers, e.g., LinksController#show.
# In Sinatra, the routing able is spread across all the various calls to get(),
# post(), and so on and the code to call lives right next to its associated
# route.

Rails.application.routes.draw do
  root to: 'links#index'

  resources :users, only: [:new, :create, :show]

  controller :links do
    post   '/links',              action: 'create', as: 'links'
    get    '/links/new',          action: 'new',    as: 'new_link'
    get    '/l/:short_name/edit', action: 'edit',   as: 'edit_link'
    get    '/l/:short_name',      action: 'show',   as: 'link'
    put    '/l/:short_name',      action: 'update'
    patch  '/l/:short_name',      action: 'update'
    delete '/l/:short_name',      action: 'destroy'
  end

  controller :sessions do
    post '/login',  action: 'create'
    get  '/logout', action: 'destroy'
  end
end
