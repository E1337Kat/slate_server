Rails.application.routes.draw do
  get 'docs_home/index' => 'docs_home#index', :as => :docs_show
  get 'docs_home/:resource_id/index' => 'docs_home#change_resource', :as => :docs_link

  get 'catch_all/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # get '/:assettype/*asset',
  #   to: static("/%{assettype}/%{asset}"),
  #   constraints: AssetConstraint.new([
  #     RegexConstraint.new("stylesheets|javascripts|images|fonts"),
  #     RegexConstraint.new("[a-zA-Z0-9]*\.[a-zA-Z0-9]*")
  #   ])

  # Matches the assets used.
  namespace :stylesheets do
    get 'print', to: static('stylesheets/print.css')
    get 'screen', to: static('stylesheets/screen.css')
  end

  namespace :javascripts do
    get 'all', to: static('javascripts/all.js')
    get 'all_nosearch', to: static('javascripts/all_nosearch.js')
  end

  namespace :images do
    get 'logo', to: static('images/logo.png')
    get 'navbar', to: static('images/navbar.png')
  end

  namespace :fonts do
    get 'slate.woff', to: static('fonts/slate.woff')
    get 'slate.woff2', to: static('fonts/slate.woff2')
    get 'slate.ttf', to: static('fonts/slate.ttf')
  end

  # Matches any resource based URL. This is the part that gets editted for new resources.
  get '/puppers/', to: static('puppers/index.html')
  get '/kittens/', to: static('kittens/index.html')
  # get '/*front/puppers/*end', to: static('puppers/index.html')
  # get '/*front/kittens/*end', to: static('kittens/index.html')

  # Matches the index
  get '/', to: static('/index.html')

  # If a route does not match, redirect.
  # get '/*any', to: static('index.html'), constraints: {
  #   any: /[a-zA-Z0-9]*\/[a-zA-Z0-9]*\/.*/
  # }
  get '*any', to: 'catch_all#index'

end
