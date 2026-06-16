class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  #ログイン後の遷移
  def after_authentication_url(user)
    user_path(user.id)
  end

  #ログアウト後の遷移
  def after_logout_url
    root_path
  end
end
