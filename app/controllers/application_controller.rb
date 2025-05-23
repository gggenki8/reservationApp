class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected

    # ログイン後の遷移先を指定
    def after_sign_in_path_for(resource)
        user_path(resource)  # ログイン後にマイページへ
    end

    # 新規登録後の遷移先を指定
    def after_sign_up_path_for(resource)
        user_path(resource)  # 登録後にマイページへ
    end
  
    def configure_permitted_parameters
      # サインアップ時に許可するカラム
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar, :introduction])
      
      # アカウント編集時に許可するカラム
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar, :introduction])
    end
  end
  