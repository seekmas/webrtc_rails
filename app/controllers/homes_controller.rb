class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! , except: [:index]
  # GET /homes
  # GET /homes.json
  def index
    if current_user and params[:user]
      current_user.nickname = params[:user][:nickname]
      current_user.save    
    end   
    @homes = Home.all
  end

  # GET /homes/1
  # GET /homes/1.json
  def show
    if @home.password != nil
      @password_chain = PasswordChain.find_by(:user_id => current_user.id , :home_id => @home.id)

      if @password_chain == nil
        redirect_to password_confirmation_path(:home_id => @home.id)
      end

    end
  end

  def password
    @home = Home.find(params[:home_id])
    @password_confirmation = Home.new

    if params[:home]
      if params[:home][:password] == @home.password
          
          PasswordChain.create({:user_id => current_user.id , :home_id => @home.id});
          redirect_to @home

      else
        redirect_to password_confirmation_path(:home_id => @home.id) , :notice => 'Password Error'
      end

    end

  end

  # GET /homes/new
  def new
    @home = Home.new
    @home.user = current_user.id
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    @home.user = current_user.id
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.require(:home).permit(:title, :user, :password, :description, :cover)
    end
end
