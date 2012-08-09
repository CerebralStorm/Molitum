class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :username, 
                  :pay_rate, :admin, :unpaid_hours, :paid_hours, :total_hours, :city, :state, :employee,
                  :zip, :phone, :address, :company_id, :role

  validates :name,  presence: true, length: { maximum: 50 }
  validates :company_id,  presence: true
  belongs_to :company
  
  has_many :time_clocks, dependent: :destroy
  has_many :quick_links, dependent: :destroy

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

  def employee?
    role == "Employee"
  end

  def employer?
    role == "Employer"
  end
end
