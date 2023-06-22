class StudentsController < GenericsController

  def update
    authorize Student
    @student = Student.find_by(user: current_user)
    @current_step = params[:student][:current_step]

    @next_step = @current_step.to_i + 1
    params[:student][:current_step] = @next_step
    @fields = Field.all
    @field_options = FieldOption.all
    
    if current_step == 1 
     @table_number = params[:student]
     @school_year = params[:student]
    end

    respond_to do |format|
      if @student.update!(student_params)
        format.html do
            redirect_to pre_registration_path(step: @next_step), notice: "Action exécutée avec succès"
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("pre_registration-form",
                                partial: "pre_registrations/step_#{ @current_step }_form",
                                locals: { student: @student })
        end
      end
    end
  end

  def show
    authorize Student
    @student = Student.find(params[:id]).decorate
    @transaction_pagy, @transactions = pagy(@student.transactions)
    @transactions = @transactions.decorate
  end

  private

  def student_params
    params.require(:student).permit(
      :last_name,
      :first_name,
      :gender,
      :nationality,
      :birth_date,
      :birth_place,
      :marital_status,
      :address,
      :email,
      :parent_address,
      :certificat_name,
      :certificat_year,
      :certificat_place,
      :certificat_country,

      :field_one_id,
      :field_two_id,
      :field_three_id,

      :field_option_one_id,
      :field_option_two_id,
      :field_option_three_id,

      :bac,
      :photo,
      :releve,
      :current_step,
    )
  end

  def filter_params
    {
      query: params[:filter][:query],
      created_from: params[:created_from],
      created_to: params[:created_to]
    } if params[:filter]
  end
end


#def generer_matricule
 # alphabet = ('A'..'Z').to_a
 # chiffres = (0..9).to_a

  # Générer une partie alphabétique de 3 caractères
 # partie_alphabetique = 3.times.map { alphabet.sample }.join('')

  # Générer une partie numérique de 3 chiffres
#  partie_numerique = 3.times.map { chiffres.sample }.join('')

  # Concaténer les deux parties pour obtenir le matricule final
 # matricule = partie_alphabetique + partie_numerique

 # return matricule
#end

# Exemple d'utilisation
#puts generer_matricule