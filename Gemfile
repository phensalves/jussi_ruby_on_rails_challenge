source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails',                 '~> 5.1.4'
gem 'puma',                  '~> 3.7'
gem 'sass-rails',            '~> 5.0'
gem 'uglifier',              '>= 1.3.0'
gem 'coffee-rails',          '~> 4.2'
gem 'turbolinks',            '~> 5'
gem 'jbuilder',              '~> 2.5'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'pg',                    '~> 0.21'
gem 'sidekiq',               '~> 4.0'
gem 'sidekiq-scheduler',     '~> 2.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara',           '~> 2.13'
  gem 'dotenv-rails',       '~> 2.2'
  gem 'pry-byebug',         '~> 3.5'
  gem 'rspec-rails',        '~> 3.7'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen',            '>= 3.0.5', '< 3.2'
  gem 'web-console',       '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
