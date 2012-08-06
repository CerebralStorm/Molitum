class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  #:lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :pay_rate, :address,
                  :total_hours, :unpaid_hours, :customer_id, :city, :state, :zip, :phone

  belongs_to :company

  VALID_PHONE_REGEX = /\d{3}[-]\d{3}[-]\d{4}/i
  VALID_ZIP_REGEX = /\d{5}/i
  VALID_ADDRESS_REGEX = /\d{1,5}\s[nsewNSEW]\s\d{1,5}\s[nsewNSEW]|\d{1,4}\s[a-zA-Z]+\s[a-zA-Z]+[.]?/i

  #validates :name,  presence: true, length: { maximum: 50 }
  #validates :city, presence: true
  #validates :state, presence: true
  #validates :address,  presence: true, format: { with: VALID_ADDRESS_REGEX }
  #validates :zip, presence: true, format: { with: VALID_ZIP_REGEX }
  #validates :phone, presence: true, format: { with: VALID_PHONE_REGEX }
  
	has_many :jobs
  has_many :customers
  has_many :time_clocks, dependent: :destroy

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
