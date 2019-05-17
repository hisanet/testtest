class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
 # layout 'admin'
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end
  def mainte_price
  end
  def output
    @order = Order.find(params[:id])
   # respond_to do |format|
      # ThinreportsでPDFを作成
      # Editorで作ったtlfファイルを読み込む
      report = Thinreports::Report.new(layout: "#{Rails.root}/app/pdfs/order_pdf.tlf")

      # 1ページ目
      report.start_new_page
   #   report.page.item(:title).value("ドキュメントタイトル")


      # valueメソッドで値を設定します
      report.page.item(:name).value(@order.name)
      # テーブルの値を設定
      # list メソッドテーブルの行に値を入れる
   

      # PDFファイルのバイナリデータを生成する
      file = report.generate


      # ブラウザでPDFを表示させたい場合
      # パラメタのdisposition: "inline" をつけない場合は、PDFがダウンロードされる
      send_data(
        file,
        filename: "{@order.id}.pdf",
        type: "application/pdf",
        disposition: "inline")
  #  end
  end


  # GET /orders/new
  def new
    @order = Order.new
    @order.ord_details.build
    @order.ord_details.build
    @order.ord_details.build
    #build ×３
   # @maint=@order.calculate_mente_price
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
   #     #あやしい
    @maint=@order.calculate_mente_price #あやしい
   # @ritu=@order.calculate_ritu
    @order.save
    @maint_year=@order.calculate_mente_yearprice #あやしい
    #保守分類計算
    @atlas=@order.calculate_atlas_mente_price
    @atlas_year=@order.calculate_atlas_yearprice
    @cs=@order.calculate_cs_mente_price
    @cs_year=@order.calculate_cs_yearprice
    @ts=@order.calculate_ts_mente_price
    @ts_year=@order.calculate_ts_yearprice
    @printer=@order.calculate_printer_mente_price
    @printer_year=@order.calculate_printer_yearprice
    @discount_month=@order.discount_month
    @virus_ics=@order.calculate_virus_ics
    @virus_other=@order.calculate_virus_other
    @calculate_mainte=@order.calculate_order_mainte_price
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if params[:preview_button]
        @order.update(order_params)
         flash[:info] = "保守計算しました"
        print "\e[31m"
          logger.debug("保守計算を実行しました")
         print "\e[0m"

        format.html { redirect_back(fallback_location: edit_order_path(:id))}
        format.json { render json: @order.errors, status: :unprocessable_entity }
      
      elsif @order.update(order_params) 
  #    if @order.update(order_params)
        format.html { redirect_to @order, notice: '更新に成功しました' }
        format.json { render :show, status: :ok, location: @order }
      else
        print "\e[31m"
          logger.debug("スキップしました")
         print "\e[0m"
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

#未使用
  def calculate
    @calculate = params[:culc]
  #  @order = Order.find(params[:id])

    logger.debug("フォームの計算を実行しました")
  #  redirect_back(fallback_location: edit_order_path(:id))
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order)
      .permit(:name, :corporation_id, :price,:tax_price,:total,:ritu,:kanyuu_price,:mainte_price,:mainte_year_price,:mainte_type,:mainte_year,:mainte_discount,:mainte_discount_month,:virus_soft_ics,:virus_soft_other,:other,:repayment,:ord_date,ord_details_attributes:[:id,:order_id, :product_id,:unit_price ,:quantity ,:price,:mainte_bool,:mainte_yearprice,:mainte,:row_order_position,:_destroy])
  end
end

