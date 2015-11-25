Rails.application.routes.draw do
  admin_for :apples do
    get 'other_route'
  end

  admin_for :bananas

  admin_for :not_obvious, controller: :other do
    collection do
      get 'responds_with_200'
    end
  end
end
