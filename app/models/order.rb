# == Schema Information
#
# Table name: orders
#
#  id                                :integer          not null, primary key
#  kanyuu_price                      :integer
#  mainte_discount                   :float            default(0.0)
#  mainte_discount_add               :float            default(0.0)
#  mainte_discount_month             :integer          default(0)
#  mainte_discount_price             :integer          default(0)
#  mainte_month                      :integer          default(0)
#  mainte_price                      :integer
#  mainte_sprit_discount_price       :float            default(0.0)
#  mainte_sprit_discount_price_total :integer          default(0)
#  mainte_sprit_price                :float            default(0.0)
#  mainte_sprit_price_total          :integer          default(0)
#  mainte_type                       :integer          default(0)
#  mainte_year                       :integer          default(0)
#  mainte_year_price                 :integer          default(0)
#  name                              :string
#  ord_date                          :date
#  other                             :text
#  price                             :integer
#  repayment                         :integer          default(0)
#  ritu                              :integer          default(0)
#  sub_total                         :integer          default(0)
#  tax_price                         :integer          default(0)
#  virus_soft_ics                    :integer          default(0)
#  virus_soft_other                  :integer          default(0)
#  virus_soft_price                  :integer          default(0)
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  corporation_id                    :integer
#

class Order < ApplicationRecord
	belongs_to :corporation,optional: true
  has_many :ord_details, dependent: :destroy
  has_many :products, through: :ord_details

  accepts_nested_attributes_for :ord_details, allow_destroy: true,reject_if: proc { |attributes| attributes['product_id'].blank? }
  before_validation :calculate_order_price,:calculate_tax_price,:calculate_total,:calculate_ritu,:calculate_mente_yearprice,:calculate_mainte,:calculate_mainte_add,:calculate_month,:calculate_virus_price
  

  def calculate_order_price
    ord_details.each(&:calculate_order_detail_price)
    self.price = ord_details.map(&:price).sum
    p "合計は¥#{self.price}"
  end
  def calculate_tax_price
    tax_price=self.price*0.08.to_f
    tax_price.floor
    self.tax_price=tax_price
    p "消費税は¥#{self.tax_price}"
  end

  def calculate_total
    self.total=self.price+self.tax_price
  end


  def calculate_ritu
      kanyuu=calculate_mente_price

    print "\e[31m"
    p "保守定価¥#{kanyuu}から率を計算しました。"
        print "\e[0m"
    if kanyuu>=3000000 && kanyuu <10000000 then
      self.ritu=85
      p "300以上"
    elsif kanyuu<3000000 && kanyuu>=1500000 then
      self.ritu=100
      p "150以上"
    elsif kanyuu < 1500000 then
      self.ritu=120
      p "150未満"
    else
      self.ritu=75
      p "1000以上"
    end
    return self.ritu
  #   p  "加入は#{ord_details.mainte_bool}"
  end

  def calculate_mente_price
    ord=ord_details.each(&:mente_agreement)
    #まだDBに保存されていないため、pluckでは更新前の数字を集計している
    self.kanyuu_price=ord_details.where("mainte_bool=?",true).map(&:mainte).sum
  p "保守算定額は¥#{self.kanyuu_price}"
    return self.kanyuu_price
  end 

  def calculate_mente_yearprice
    ord_details.each(&:mente_detail)
    self.mainte_year_price=ord_details.where("mainte_bool=?",true).pluck(:mainte_yearprice).sum
  end 
  def calculate_atlas_mente_price
    @atlas=ord_details.atlas
    @atlas.where("mainte_bool=?",true).pluck(:mainte).sum
  end 
  def calculate_atlas_yearprice
    @atlas=ord_details.atlas
    @atlas.where("mainte_bool=?",true).pluck(:mainte_yearprice).sum
  end 
  def calculate_cs_mente_price
    @cs=ord_details.cs
    @cs.where("mainte_bool=?",true).pluck(:mainte).sum
  end
  def calculate_cs_yearprice
    @cs=ord_details.cs
    @cs.where("mainte_bool=?",true).pluck(:mainte_yearprice).sum
  end
  def calculate_ts_mente_price
    @ts=ord_details.ts
    @ts.where("mainte_bool=?",true).pluck(:mainte).sum
  end  
  def calculate_ts_yearprice
    @ts=ord_details.ts
    @ts.where("mainte_bool=?",true).pluck(:mainte_yearprice).sum
  end
  def calculate_printer_mente_price
    @printer=ord_details.printer
    @printer.where("mainte_bool=?",true).pluck(:mainte).sum
  end  
  def calculate_printer_yearprice
    @printer=ord_details.printer
    @printer.where("mainte_bool=?",true).pluck(:mainte_yearprice).sum
  end
  def calculate_mainte_discount
    #定価の割引
    month=self.mainte_month/12.to_f
    init_mainte_sprit
    if self.mainte_type==0
      self.mainte_discount=0
    elsif self.mainte_type==1  
      if month<2.5
        self.mainte_discount=100
      elsif month>=2.5 && month<3.5
        self.mainte_discount=89
      elsif month>=3.5 && month<4.5
        self.mainte_discount=85
      else
        self.mainte_discount=80  
      end
    elsif self.mainte_type==2
      calculate_mainte_sprit
      calculate_mainte_sprit_total
      if month<2.5
        self.mainte_discount=100
      elsif month>=2.5 && month<3.5
        self.mainte_discount=94
      elsif month>=3.5 && month<4.5
        self.mainte_discount=92
      else
        self.mainte_discount=90  
      end
    else
      self.mainte_discount=0
    end 
    return self.mainte_discount
  end

  def calculate_mainte_discount_add
    #追加の割引
    month=(self.mainte_month-self.mainte_discount_month)/12.to_f
    init_mainte_sprit
    if self.mainte_type==0
      self.mainte_discount_add=0
    elsif self.mainte_type==1  
      if month<2.5
        self.mainte_discount_add=100
      elsif month>=2.5 && month<3.5
        self.mainte_discount_add=89
      elsif month>=3.5 && month<4.5
        self.mainte_discount_add=85
      else
        self.mainte_discount_add=80  
      end
    elsif self.mainte_type==2
      calculate_mainte_sprit
      calculate_mainte_sprit_discount
      calculate_mainte_sprit_total
      calculate_mainte_sprit_discount_total
      if month<2.5
        self.mainte_discount_add=100
      elsif month>=2.5 && month<3.5
        self.mainte_discount_add=94
      elsif month>=3.5 && month<4.5
        self.mainte_discount_add=92
      else
        self.mainte_discount_add=90  
      end
    else
      self.mainte_discount_add=0
    end 
    return self.mainte_discount_add
  end

  def calculate_month
    if self.mainte_year>1
      self.mainte_month=self.mainte_year*12-6
    else
      self.mainte_month=0
    end
  end
  def discount_month
    calculate_month
    month=self.mainte_month-self.mainte_discount_month
    return month
  end

  def calculate_mainte
    discount=calculate_mainte_discount/100

    month=self.mainte_month/12.to_f
   self.mainte_price = self.mainte_year_price*month*discount
    return self.mainte_price
  end
   def calculate_mainte_add
    discount=calculate_mainte_discount_add/100
    p "値引き計算は¥#{discount}"
    month=(self.mainte_month-self.mainte_discount_month)/12.to_f
    p "値引き計算は¥#{month}"
   self.mainte_discount_price = self.mainte_year_price*month*discount
    return self.mainte_discount_price
  end
  def discount_price
    if self.mainte_type==1
      return self.mainte_price-self.mainte_discount_price
    elsif self.mainte_type==2
      return self.mainte_sprit_price_total-self.mainte_sprit_discount_price_total
    end
  end

  def init_mainte_sprit
    self.mainte_sprit_price=0
    self.mainte_sprit_discount_price=0
    self.mainte_sprit_price_total=0
    self.mainte_sprit_discount_price_total=0
  end
  def calculate_mainte_sprit
    tuki=self.mainte_year*12.to_f
    self.mainte_sprit_price = self.mainte_price.to_f/tuki
    self.mainte_sprit_price = self.mainte_sprit_price.ceil
  end
  def calculate_mainte_sprit_discount
    tuki=self.mainte_year*12.to_f
    self.mainte_sprit_discount_price = self.mainte_discount_price.to_f/tuki
    self.mainte_sprit_discount_price = self.mainte_sprit_discount_price.ceil
  end
  def calculate_mainte_sprit_total
    self.mainte_sprit_price_total = self.mainte_sprit_price*self.mainte_year*12
  end
  def calculate_mainte_sprit_discount_total
    self.mainte_sprit_discount_price_total = self.mainte_sprit_discount_price*self.mainte_year*12
  end

  def calculate_virus_ics
    return self.mainte_month*203*self.virus_soft_ics
  end
  def calculate_virus_other
    self.mainte_year*12*203*self.virus_soft_other
  end
  def calculate_virus_price
    self.virus_soft_price=calculate_virus_ics+calculate_virus_other
  end
  def calculate_order_mainte_price
    sals=(self.mainte_discount_price+self.virus_soft_price-self.discount_price-self.repayment)*0.7.to_f
    sals.floor
  end

end
