class EtudiantsController < ApplicationController
  
  before_action :set_etudiant, only: %i[ show update ]
    #authorize Etudiant
    #@etudiant = Etudiant.find_by(user: current_user)

  # GET /etudiants or /etudiants.json
  def index
    @etudiants = Etudiant.all
  end

  # GET /etudiants/1 or /etudiants/1.json
  def show
  end

  # GET /etudiants/new
  def new
    @etudiant = Etudiant.new
  end

  # GET /etudiants/1/edit
  def edit
  end

  # POST /etudiants or /etudiants.json
  def create
    @etudiant = Etudiant.new(etudiant_params)

    respond_to do |format|
      if @etudiant.save
        format.html { redirect_to etudiant_url(@etudiant), notice: "Etudiant was successfully created." }
        format.json { render :show, status: :created, location: @etudiant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @etudiant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /etudiants/1 or /etudiants/1.json
  def update
    authorize Etudiant
    @student = Etudiant.find_by(user: current_user)
    respond_to do |format|
      if @etudiant.update(etudiant_params)
        format.html { redirect_to etudiant_url(@etudiant), notice: "Etudiant was successfully updated." }
        format.json { render :show, status: :ok, location: @etudiant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @etudiant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /etudiants/1 or /etudiants/1.json
  def destroy
    @etudiant.destroy

    respond_to do |format|
      format.html { redirect_to etudiants_url, notice: "Etudiant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etudiant
      @etudiant = Etudiant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def etudiant_params
      params.require(:etudiant).permit(
        :matricule, 
        :first_name, 
        :last_name, 
        :gender, 
        :birth_date, 
        :birth_place, 
        :nationality, 
        :marital_status, 
        :email, 
        :address, 
        :parent_address, 
        :user_id, 
        :certificat_name, 
        :certificat_year, 
        :certificat_place, 
        :certificat_country, 
        :field_id, 
        :field_option_id, 
        :fac
        )
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
