CarrierWave.configure do |config|
  config.storage = :upyun
  config.upyun_username = "sanvi1020"
  config.upyun_password = 'air20dream'
  config.upyun_bucket = "image-sanvibyfish"
  config.upyun_bucket_domain = "image-sanvibyfish.b0.upaiyun.com"
end