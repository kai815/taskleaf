class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  private

  # ログインしているユーザーを取得処理をコントローラやビューから呼び出しやすくする
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  #ログインしてなかったらログイン画面にリダイレクト。よく使うのでここに書く
  def login_required
    redirect_to login_path unless current_user
  end
end
