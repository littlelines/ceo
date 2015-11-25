Rails.application.routes.draw do
  admin_for :apples do
    get 'other_route'
  end

  admin_for :bananas
end
