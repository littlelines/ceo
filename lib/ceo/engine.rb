module CEO
  class Engine < Rails::Engine

    config.to_prepare do
      Rails.application.config.assets.precompile += %w(
        app/assets/stylesheets/ceo/*
      )
    end

  end
end

