source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5'
# Use Puma as the app server
gem 'puma', '~> 5.0'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'hirb'
  gem 'hirb-unicode'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :production do 
  gem 'fog-aws'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'

# .envファイル使用
gem 'dotenv-rails'

# Devise
gem 'devise_token_auth'

#メッセージの日本語化
gem 'devise-i18n'

# フロントとの接続設定
gem 'rack-cors'

# 画像投稿
gem 'carrierwave'


