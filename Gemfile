ruby '2.6.5'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 6.0.x'
gem 'pg'
gem 'haml'
gem 'jquery-rails'
gem 'puma'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem "webpacker"
gem 'mini_racer', platforms: :ruby
gem 'coffee-rails'
gem 'sorcery'
gem 'rails_12factor'
gem 'turbolinks'
gem 'groupdate'
gem 'kramdown'
gem 'httparty'
gem "nokogiri", ">= 1.10.4"
gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'date_validator'
gem "sentry-raven"
gem 'dalli'
gem 'sitemap_generator'
gem 'meta-tags'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'scout_apm'
gem 'redis'
gem 'kaminari'
gem 'oj' # json
gem 'webpacker-svelte'
gem "autoprefixer-rails"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.0'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'selenium-webdriver'
  gem 'webmock'
  gem 'vcr'
  gem 'shoulda-matchers'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rack-mini-profiler'
  gem "bullet"
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
