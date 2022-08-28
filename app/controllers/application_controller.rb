class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  ##　新規登録画面で、デバイスのデフォルトで登録可能なname,email以外を設定する場合、keys以下の記述が必要
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name_kana, :last_name_kana, :first_name, :postal_code, :address, :telephone_number])
  end

  private
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
