class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:owner, :show, :new, :create, :edit, :update, :destroy]

  def owner
    @students = Student.where(user: current_user)
  end

  # GET /students
  # GET /students.json
  def index
    @students = Student.all

  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
     @user = current_user
  end

  # GET /students/1/edit
  def edit
    @user = current_user
    @student = Student.find_by(id: params[:id])
    @plan = Splan.find_by!(id: @student.splan_id)
    Stripe.api_key = @user.access_code #replace with @user.access_code
    @publishable_key = @user.publishable_key #replace with @user.publishable_key
 end
  # POST /students
  # POST /students.json
  def create
    @student = current_user.students.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    

    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to owner_path, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:splan_id, :first_name, :last_name, :email, :phone_number, :street_address, :city, :state, :zip, :emergency_contact_name, :emergency_contact_phone, :emergency_contact_relationship, :emergency_medical_info, :belt_size, :uniform_size, :birthday)
    end
end
