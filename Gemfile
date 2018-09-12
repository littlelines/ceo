source 'https://rubygems.org'

gemspec

# from: http://aaronmiler.com/blog/testing-your-rails-engine-with-multiple-versions-of-rails/
rails_version = ENV['RAILS_VERSION'] || 'default'
rails = case rails_version
        when 'master'
          { github: 'rails/rails' }
        when 'default'
          '5.0.5'
        else
          "~> #{rails_version}"
        end
