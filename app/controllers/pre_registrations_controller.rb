class PreRegistrationsController < AuthController
  def show
    @student = Student.find_by(user: current_user)
    @current_step = params[:step] || '1'
    @student.current_step = @current_step

    @fields = Field.all
    @field_options = FieldOption.all
    
    @import_students = ImportStudent.all

  end
  def success
    
  end
end
