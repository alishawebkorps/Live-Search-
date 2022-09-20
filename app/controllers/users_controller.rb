class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]

  # GET /users or /users.json
  def index
    @users = User.all 
    @address = Address.all   
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @address = Address.new
  end

  
  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
     if @user.save
        @address = Address.create({
          city: params[:user][:address][:city] ,
          country: params[:user][:address][:country] ,
          pin_code: params[:user][:address][:pin_code] ,
          state: params[:user][:address][:state] ,
          street: params[:user][:address][:street] ,
          house_no: params[:user][:address][:house_no] ,
          distt: params[:user][:address][:distt] ,
          user_id: @user.id })
          @address.save!
        format.html { redirect_to root_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
        
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def search
    @address = Address.where("city LIKE? OR country LIKE? OR distt LIKE? OR state LIKE?" , "%#{params[:q]}%", "%#{params[:q]}%","%#{params[:q]}%", "%#{params[:q]}%")
    respond_to do |format|
      format.js
      format.html
    end
  end
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:name, :phone_no, :email, :address => [])
      end
  
     def address_params
      params.require(:user).permit(:address)
     end
  
end
