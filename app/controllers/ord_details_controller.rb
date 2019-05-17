class OrdDetailsController < ApplicationController
  before_action :set_ord_detail, only: [:show, :edit, :update, :destroy]

  # GET /ord_details
  # GET /ord_details.json
  def index
    @ord_details = OrdDetail.all
  end


  # GET /ord_details/1
  # GET /ord_details/1.json
  def show
  end

  # GET /ord_details/new
  def new
    @ord_detail = OrdDetail.new
  end

  # GET /ord_details/1/edit
  def edit
    @ord_detail = OrdDetail.rank(:row_order)
  end

  # POST /ord_details
  # POST /ord_details.json
  def create
    @ord_detail = OrdDetail.new(ord_detail_params)
  #  render ord_detail: params inspect
    respond_to do |format|
      if @ord_detail.save
        format.html { redirect_to @ord_detail, notice: 'Ord detail was successfully created.' }
        format.json { render :show, status: :created, location: @ord_detail }
      else
        format.html { render :new }
        format.json { render json: @ord_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ord_details/1
  # PATCH/PUT /ord_details/1.json
  def update
    respond_to do |format|
      if @ord_detail.update(ord_detail_params)
        format.html { redirect_to @ord_detail, notice: 'Ord detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @ord_detail }
      else
        format.html { render :edit }
        format.json { render json: @ord_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ord_details/1
  # DELETE /ord_details/1.json
  def destroy
    @ord_detail.destroy
    respond_to do |format|
      format.html { redirect_to ord_details_url, notice: 'Ord detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
    def search
    respond_to do |format|
      format.json { render json: @ord_detail = OrdDetail.search(params[:q]) }
    end
  end

  def update_row_order
    @ord_detail = OrdDetail.find(ord_detail_params[:ord_detail_id])
    @ord_detail.row_order_position = ord_detail_params[:row_order_position]
    @ord_detail.save

    render body: nil
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ord_detail
      @ord_detail = OrdDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ord_detail_params
      params
        .require(:ord_detail).permit(OrdDetail::REGISTRABLE_ATTRIBUTES)
       # .permit(:order_id, :product_id, :unit_price, :quantity, :price)
       # .permit(OrdDetail::REGISTRABLE_ATTRIBUTES)
        
    end
end
