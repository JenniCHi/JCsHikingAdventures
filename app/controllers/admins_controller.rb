class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def attempt_authorise
      if session[:admin]
        #If the user already recieved admin privileges, they get redirected to
        #the authorise view where they get this message.
        flash[:notice] = "You have already been granted admin privileges for this session"
        redirect_to :action=> :authorise
      end
  end
  
  #This method checks the code that the user entered to gain admin access
  #matches the code we have stored in the database.
  # GET /admins/authorise
  def authorise
    #Only attempts to authorise the user if they haven't already been authorised.
    if !session[:admin]
      adminCode = params[:q].to_i
      
      #Fetches the correct admin code from the database.
      adminAuth = Admin.first
      if adminAuth.admin_code == adminCode  
        #If the codes match, setting session[:admin] = true allows the user
        #to see CRUD options on Adventures.
        session[:admin] = true
        flash[:notice] = "You've been temporarily granted admin privileges"
      else
        flash[:notice] = "Admin credentials incorrect"
      end
    end
  end
  
  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:admin_id, :admin_code)
    end
end
