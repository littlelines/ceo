Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'admin#dashboard'
    get 'styleguide', to: 'admin#styleguide'
  end
end

