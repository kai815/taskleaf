class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  # ログインしているユーザーを取得処理をコントローラやビューから呼び出しやすくする
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
