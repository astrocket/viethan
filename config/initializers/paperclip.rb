if Rails.env == 'production'
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:s3_protocol] = :https
  Paperclip::Attachment.default_options[:s3_region] = 'ap-northeast-2'
  Paperclip::Attachment.default_options[:s3_host_name] = 's3-ap-northeast-2.amazonaws.com'
  Paperclip::Attachment.default_options[:s3_credentials] = {
      :bucket => ENV['VIET_BUCKET_NAME'],
      :access_key_id => ENV['VIET_ACCESS_KEY'],
      :secret_access_key => ENV['VIET_SECRET_KEY']
  }
else
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:s3_protocol] = :https
  Paperclip::Attachment.default_options[:s3_region] = 'ap-northeast-2'
  Paperclip::Attachment.default_options[:s3_host_name] = 's3-ap-northeast-2.amazonaws.com'
  Paperclip::Attachment.default_options[:s3_credentials] = {
      :bucket => ENV['ASTRO_BUCKET_BOX'],
      :access_key_id => ENV['VIET_ACCESS_KEY'],
      :secret_access_key => ENV['VIET_SECRET_KEY']
  }
end

Paperclip.interpolates :topic_name  do |attachment, style|
  "#{attachment.instance.title}(id: #{attachment.instance.id})"
end
