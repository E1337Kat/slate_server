Rails.application.routes.draw do

  # User navigated to the root (this is good!)
  root :to => 'docs#index'

  # User navigated to some page. 
  get 'index' => 'docs#index', :as => :docs_show
  get ':resource_id/index' => 'docs#change_resource', :as => :docs_link

  # User went somewhere they should not have gone.
  get 'catch_all/index'
  get '*any', to: 'catch_all#index'

end
