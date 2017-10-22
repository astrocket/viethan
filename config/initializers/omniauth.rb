if Rails.env == 'production'
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV["VIET_FB_APP_ID"], ENV["VIET_FB_APP_SECRET"]
  end
else
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV["VIET_FB_APP_ID"], ENV["VIET_FB_APP_SECRET"]
  end
end
