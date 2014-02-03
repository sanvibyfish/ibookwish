CarrierWave.configure do |config|
  config.storage = :upyun
  config.upyun_username = "xx"
  config.upyun_password = 'xxx'
  config.upyun_bucket = "image-sanvibyfish"
  config.upyun_bucket_domain = "image.ibookwish.com"
end