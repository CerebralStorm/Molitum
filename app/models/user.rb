class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :username, 
                  :pay_rate, :admin, :unpaid_hours, :paid_hours, :total_hours, :city, :state, :employee,
                  :zip, :phone, :address

  validates :name,  presence: true, length: { maximum: 50 }
  
  has_one :company
  
  has_many :time_clocks, dependent: :destroy
  has_many :quick_links, dependent: :destroy

  before_save :set_blank_attributes

  def unpaid_dollar_amount
    amount = self.unpaid_hours * self.pay_rate
  end

  def add_unpaid_hours(hours)
    self.unpaid_hours += hours
    self.save
  end

  def subtract_unpaid_hours(hours)
    self.unpaid_hours -= hours
    self.save
  end

  def add_total_hours(hours)
    self.total_hours += hours
    self.save
  end

  def subtract_total_hours(hours)
    self.total_hours -= hours
    self.save
  end

  def earnings_ytd
    (self.total_hours * pay_rate) - (self.unpaid_hours * pay_rate)
  end

  def set_blank_attributes
    address.nil? ? "" : address
    city.nil? ? "" : city
    state.nil? ? "" : state
    zip.nil? ? "" : zip
    phone.nil? ? "" : phone
  end
end
