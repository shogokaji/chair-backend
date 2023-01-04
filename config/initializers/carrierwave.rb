require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
 if Rails.env.production?
   config.storage :fog
   config.fog_provider = 'fog/aws'
   config.fog_directory  = 'chair-front'
   config.fog_public = false
   config.fog_credentials = {
     provider: 'AWS',
     aws_access_key_id: ENV['AWS_ACCESS_KEY'],
     aws_secret_access_key: ENV['AWS_SECRET_KEY'],
     region: 'ap-northeast-1',
     path_style: true
   }
   config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/chair-front'
 else
  config.asset_host = "http://localhost"
  config.storage = :file
  config.cache_storage = :file
 end
end
