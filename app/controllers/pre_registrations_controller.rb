class PreRegistrationsController < AuthController
  def show
    @student = Student.find_by(user: current_user)
    @current_step = params[:step] || '1'
    @student.current_step = @current_step
  end
end
