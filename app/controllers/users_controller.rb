class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]



  # GET /users
  # GET /users.json
  def index
  
#テーブルの並び替え(ドラッグドロップ) rank使用
     # @users = User.all
    @users = User.rank(:row_order)
 
  # グループで集計の機能
    pivotes = User.left_outer_joins(:sales).group("users.name").sum(:sale_co) 
    @labels = pivotes.map(&:first)
    @datas = pivotes.map(&:second)
  end

  def update_row_order
    @user = User.find(user_params[:user_id])
    @user.row_order_position = user_params[:row_order_position]
    @user.save
    render body: nil
  end


  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    respond_to do |format|
      format.json { render json: @users = User.search(params[:q]) }
    end
  end

  def sort
  #  user = User.find(params[:user_id])
   # user.update(users_params)
    #render nothing: true
    @user = User.find(user_params[:user_id])
    @user.row_order_position = user_params[:row_order_position]
    @user.save

    render body: nil
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
    #  params.require(:user).permit(:name, :email, :age, :team_id)
      params.require(:user).permit(:user_id,:name, :email, :age, :team_id,:row_order_position)
    #row_order ではなく、row_order_positionなのはgemの仕様
    end
end
