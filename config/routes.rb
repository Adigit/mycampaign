Rails.application.routes.draw do
  get 'profile/index'
	namespace :mobile do
		resources "coupon"
		resources "feedback"
		resources "notification"
		resources "push"
    #	resources "load"
	end
	namespace :member do 
		namespace :campaigns do 
			resources "web"
			resources "mobile"
		end
	end

  #   devise_for :users, controllers: {sessions: "sessions"}
	devise_for :users
  #devise_for :testing
  #  get 'home/index'
  post "/api/wp/notifier"
  get "/api/wp/notifier"
  root :to => "home#index"
	post "/akhil/index"
  get "/akhil/index"
  post "/home/test_action"
  post "/web/load/index"
  post "/mobile/load/index"
	get "/mobile/load/index"	
	get "/web/load/index"
  
  post "/web/load/record_analytics"
	get "/web/load/record_analytics"
  post "/web/load/save_email_in_db"
  post "/web/load/save_feedback_in_db"
  get "/web/load/send_image_url"
  get '/testing_web_campaigns/index'
  post "/testing/update"
  post "/home/campaign"
  post "/home/send_code_via_email"
  post "/home/move_to_configure_page"
  get "/home/setup"
	get "/home/how_it_works"
	get "/home/pricing"
	get "/home/privacy"
	get "/home/terms-and-conditions", :to => "home#terms_and_conditions"
	get "/about/index"
	get "/about/careers"
	get "/about/testimonials"
	get "/about/partners"
	get "/about/preferred_partners"
	get "/about/non_profit"
	get "/about/contact_us"
  get "/integrationguide/index"
	post "/member/campaigns/web/refresh"
	get "/member/campaigns/web/refresh"
	post "/member/campaigns/web/create"
	post "/member/setup/web/feedback/edit"
	post "/member/campaigns/web/app_create"
	post "/member/setup/web/notification/edit"
	get "/member/setup/web/notification/edit"
	post "/member/setup/web/coupon/edit"
	post "/member/campaigns/web/leads_graph"
	post "/member/campaigns/web/graph"
	post "/member/setup/web/feedback/create_or_update"
	post "/member/setup/web/coupon/create_or_update"
	post "/member/setup/web/notification/create_or_update"
	get "/member/setup/web/feedback/edit"
	get "/member/campaigns/web/plot_graph"
	get "/member/campaigns/web/plot_graph", :to => "member#campaigns#web#show"
	get "/member/campaigns/mobile/plot_graph", :to => "member#campaigns#mobile#show"
	get "/web/notification/intro"
	get "/web/feedback/intro"
	get "/web/coupon/intro"
	get "/mobile/pushmessages/intro"
	get "/member/campaigns/mobile"
	post "/member/campaigns/mobile/refresh"
	post "/member/campaigns/mobile/app_create"
	post "/member/campaigns/mobile/create"
	post "/member/setup/mobile/feedback/edit"
	post "/member/setup/mobile/feedback/create_or_update"
	post "/member/setup/mobile/coupon/create_or_update"
	post "/member/setup/mobile/notification/create_or_update"
	post "/member/setup/mobile/push_notification/create_or_update"
	post "/member/setup/web/notification/delete"
	post "/member/setup/web/coupon/delete"
	post "/member/setup/web/feedback/delete"
  post "/member/setup/mobile/notification/delete"
  post "/member/setup/mobile/coupon/delete"
  post "/member/setup/mobile/feedback/delete"
  get "/integrations/index"
  get "/integrations/blogger"
  get "/integrations/bigcommerce"
  get "/integrations/magento"
  get "/integrations/wordpress"
  get "/integrations/shopify"
  get "/integrations/tumblr"
  get "/integrations/buildabazaar"
	get "/member/mobile/feedback"
	post "/member/setup/mobile/coupon/edit"
	get "/member/setup/mobile/coupon/edit"
	post "/member/setup/mobile/feedback/edit"
	get "/member/setup/mobile/feedback/edit"
	post "/member/setup/mobile/notification/edit"
	post "/member/setup/mobile/push_notification/edit"
  get "/member/setup/mobile/push/edit"
	post "/member/campaigns/mobile/graph"
	post "/member/campaigns/mobile/leads_graph"
	post "/member/setup/mobile/push/edit"
	post "/member/setup/mobile/push/create_or_update"
	get "/admin/home/index" 
	get "/admin/home/edit"
	get "/admin/home/new"
	get "/admin/home/destroy"
	post "/admin/home/create"	
	post "/admin/home/update"
  get "/admin/home/delete_this"
	post "/sns/sns_endpoint"
	get "/sns/sns_endpoint"
	post "/home/create_widget"
	get "/member/setup/website_notification"
	get "/member/setup/web/coupon/edit"
  get "/home/campaign"
	#get "/admin/home/destroy", :to => "admin#home#destroy"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
