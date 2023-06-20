class ImportStudentsController < AuthController
  def new
    @import_student = ImportStudent.new
  end

  def show
    @import_student = ImportStudent.find()
  end

  def create
    @import_student = ImportStudent.new(import_student_params)
    
    if @import_student.save
      ImportStudentsWorker.perform_async(@import_student.id, current_university.id)
      redirect_to students_path, notice: "Importation en cours"
    else
      redirect_to students_path, notice: "Echec reprenez"
    end
  end

  private

  def import_student_params
    params.require(:import_student).permit(
      :file
    )
  end
end
