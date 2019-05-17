# == Schema Information
#
# Table name: ord_details
#
#  id               :integer          not null, primary key
#  mainte           :integer
#  mainte_bool      :boolean          default(TRUE), not null
#  mainte_yearprice :integer
#  price            :integer
#  quantity         :integer
#  row_order        :integer
#  unit_price       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  order_id         :integer
#  product_id       :integer
#

class OrdDetail < ApplicationRecord
	REGISTRABLE_ATTRIBUTES = %i(order_id product_id unit_price quantity price mainte_bool mainte_yearprice mainte ord_detail_id row_order_position)

	belongs_to :order
 	belongs_to :product
	

	scope :search, lambda { |query| where('name LIKE ?', "%#{query}%").limit(100) }
  #scope :search_category, ->(id) { includes(product:[:category]).where("products.category_id = ?", id).references(:products) }
  scope :atlas, -> { includes(product:[:category])
    .where("(products.category_id = ?) or (products.category_id = ?) or (products.category_id = ?) or (products.category_id = ?) ", 1,2,8,10)
    .references(:products) }
  scope :cs, -> { includes(product:[:category]).where("products.category_id = ?", 3)
    .references(:products) }
  scope :ts, -> { includes(product:[:category]).where("products.category_id = ?", 4)
    .references(:products) }
  scope :ocr, -> { includes(product:[:category]).where("products.category_id = ?", 9)
    .references(:products) }
  scope :printer, -> { includes(product:[:category]).where("(products.category_id = ?) or (products.category_id = ?)", 7,9)
    .references(:products) }
  #scope :printer, -> { includes(product:[:category]).where("products.category_id = ?", 7)
   # .references(:products) }

 	def calculate_order_detail_price
	    self.price = unit_price * quantity
	    p "小計は￥#{self.price}"
	  rescue
	    self.price = 0
  end
  def mente_agreement
 #年計の計算
      if mainte_bool
         
        @mente = Product.find(self.product_id )
      #  self.mainte_yearprice=@mente.mainte_yearprice
        case @mente.category_id 
        when 1 then
          self.mainte = unit_price * quantity   
          p "Atlas算定額#{self.mainte}"
        when 2 then
          self.mainte = unit_price * quantity
          p "CL算定額#{self.mainte}"
        when 3 then
          self.mainte = unit_price * quantity
          p "CS算定額#{self.mainte}"
        when 4 then
          self.mainte = 0
          p "TS算定額は#{self.mainte}"
        when 5 then
          self.mainte = 0
          p "同時使用算定額は#{self.mainte}"
        when 6 then
          self.mainte = 0
          p "CAL算定額は#{self.mainte}"
        when 7 then
          self.mainte = unit_price * quantity
          p "プリンタ算定額#{self.mainte}"
        when 8 then
          self.mainte = unit_price * quantity
          p "(メモリ)算定額#{self.mainte}"
        when 9 then
          self.mainte = unit_price * quantity
          p "OCR加算"
        when 10 then
          self.mainte = unit_price * quantity
          p "(オプション)算定額#{self.mainte}"
        when 11 then
          self.mainte = 0
          p "計算しない"
        end
        
      else
        self.mainte =0
        self.mainte_yearprice=0
         p "未加入は#{self.mainte}"
      end
  end
  	def mente_detail
     #ここで率の計算すると何回も集計繰り返す
      ritu=order.ritu
      #年計の計算
  		if mainte_bool
        @mente = Product.find(self.product_id )
        self.mainte_yearprice=@mente.mainte_yearprice
  		 	case @mente.category_id 
  		 	when 1 then   
          self.mainte_yearprice=(self.mainte*ritu)/1000
  		 		p "mente×#{order.ritu}率の計算を年額(AT)"
  		 	when 2 then
          self.mainte_yearprice=(self.mainte*ritu)/1000
  		 		p "mente×率の計算を年額(CL)"
  		 	when 3 then
          case ritu
          when 85 then
            self.mainte_yearprice=36000*quantity
          when 75 then
            self.mainte_yearprice=30000*quantity
          else
            self.mainte_yearprice=40000*quantity
          end
  		 		p "CS計算は年額#{self.mainte_yearprice}"
  		 	when 4 then
          if quantity>=1 && quantity<=5
            self.mainte_yearprice=20000*quantity
          elsif quantity>5 && quantity<=10
            self.mainte_yearprice=(16000*(quantity-5))+100000
          elsif quantity>10 && quantity<=20
            self.mainte_yearprice=(13000*(quantity-10))+180000
          elsif quantity>20 && quantity<=30
            self.mainte_yearprice=(10000*(quantity-20))+310000
          elsif quantity>30 && quantity<=40
            self.mainte_yearprice=(8000*(quantity-30))+410000
          elsif quantity>40 
            self.mainte_yearprice=(7000*(quantity-40))+490000
          else
            self.mainte_yearprice=0
          end
          self.mainte = 0
  		 		p "TS計算は年額#{self.mainte_yearprice}"
  		 	when 5 then
          self.mainte_yearprice=0
  		 		p "同時使用"
  		 	when 6 then
          self.mainte_yearprice=0
          p "計算しない"
  		 	when 7 then
          p "プリンタ年額" 
  		 	when 8 then
          self.mainte_yearprice=(self.mainte*ritu)/1000
  		 		p "mente×率の計算を年額(メモリ)"
        when 9 then
          p "OCR年額"
        when 10 then
          self.mainte_yearprice=(self.mainte*ritu)/1000
          p "mente×率の計算を年額(オプション)"
        when 11 then
          self.mainte_yearprice=0
          p "計算しない"
  		 	end	

  		 	
  		else
  			self.mainte =0
        self.mainte_yearprice=0
  			 p "未加入は#{self.mainte}"
  		end
      return self.mainte_yearprice
  	end



 # OrdDetail.calculate_order_detail_price
# OrdDetail.new.calculate_order_detail_price
#  helper_method :calculate_order_detail_price
end
