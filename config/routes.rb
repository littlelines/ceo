Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard', to: 'admin#dashboard'
    get 'styleguide', to: 'admin#styleguide'
  end
end

