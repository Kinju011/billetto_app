class ApplicationController < ActionController::Base
  include Clerk::Authenticatable

  helper_method :current_user_id, :user_signed_in?

  private

  def current_user_id
    clerk.user_id
  end

  def user_signed_in?
    clerk.user?
  end

  def require_authentication!
    unless user_signed_in?
      respond_to do |format|
        format.html { redirect_to root_path, alert: "You must be logged in to perform this action." }
        format.turbo_stream { redirect_to root_path, alert: "You must be logged in to perform this action." }
      end
    end
  end
end
