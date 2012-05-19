class HomeController < ApplicationController
  before_filter :direct_valid_sessions_to_dashboard, only: [:index]
  before_filter :direct_invalid_sessions_to_landing, only: [:dashboard]
  def index
  end
  
  def dashboard
    @dc = current_user.api.send(:dc_from_api_key).gsub('.','')
  end
  
  private
  
    def direct_valid_sessions_to_dashboard
      redirect_to dashboard_url if user_signed_in?
    end
    
    def direct_invalid_sessions_to_landing
      redirect_tp root_url unless user_signed_in?
    end
end