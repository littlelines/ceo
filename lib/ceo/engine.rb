module CEO
  class Engine < Rails::Engine

    config.autoload_paths << File.expand_path("../../app/inputs/ceo", File.dirname(__FILE__))

    config.to_prepare do
      Rails.application.config.assets.precompile += %w(
        app/assets/stylesheets/ceo/*
      )
    end
  end
end
