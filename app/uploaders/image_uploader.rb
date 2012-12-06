# coding: utf-8
# 在图片空间里面定义好的“缩略图版本名称”，以防止调用错误
IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES = %(20x20 30x30 240x240 360x360 100x100 120x90 160x120 250x187 320 640 800 48x48)
class ImageUploader < CarrierWave::Uploader::Base

  storage :upyun

  
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}"
  end

  def default_url
    # 搞一个大一点的默认图片取名 blank.png 用 FTP 传入图片空间，用于作为默认图片
    # 由于有自动的缩略图处理，小图也不成问题
    # Setting.upload_url 这个是你的图片空间 URL
    "#{Setting.upload_url}/blank.png#{version_name}"
  end

  # 覆盖 url 方法以适应“图片空间”的缩略图命名
  def url(version_name = "")
    @url ||= super({})
    version_name = version_name.to_s
    return @url if version_name.blank?
    if not version_name.in?(IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES)
      # 故意在调用了一个没有定义的“缩略图版本名称”的时候抛出异常，以便开发的时候能及时看到调错了
      raise "ImageUploader version_name:#{version_name} not allow."
    end
    [@url,version_name].join("!") # 我这里在图片空间里面选用 ! 作为“间隔标志符”
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    if super.present?
      model.uploader_secure_token ||= SecureRandom.uuid.gsub("-","")
      Rails.logger.debug("(BaseUploader.filename) #{model.uploader_secure_token}")
      "#{model.uploader_secure_token}.#{file.path.split('.').last}"
    end
  end
end

