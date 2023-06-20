class UsersController < GenericsController

  def profile
    @user = current_user
  end

  def impersonate
    sign_out and return unless current_user.is_admin?
    user = User.find(params[:id])
    redirect_to users_path, notice: "Université erreur" and return unless user.university.present?
    session[:admin_id] = current_user.id
    bypass_sign_in(user)
    redirect_to dashboard_url(subdomain: user.university.slug), allow_other_host: true and return
  end

  def unimpersonate
    unless impersonating?
      sign_out
      redirect_to(new_user_session_path)
      return
    end

    bypass_sign_in(User.find(session[:admin_id]))
    session[:admin_id] = nil
    redirect_to users_url(subdomain: false), allow_other_host: true
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :profile,
      :avatar,
      :password,
      :password_confirmation,
      :university_id,
    )
  end

  def filter_params
    {
      query: params[:query],
      current_user: current_user,
      created_from: params[:created_from],
      created_to: params[:created_to]
    }
  end
end
