class ApplicationController < ActionController::Base
  before_action :configure_authentication
  before_action :check_guest_user, only: [:create, :update]
 
  private
  
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end
  
  def check_guest_user
    if user_signed_in? && current_user.guest?
      redirect_to request.referer, alert: 'ゲストユーザーはこの操作を実行できません。'
    end
  end
 
  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_user! unless action_is_public?
    end
  end
 
  def action_is_public?
    controller_name == 'homes' && action_name == 'top'
  end
end
