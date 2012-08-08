class Company < ActiveRecord::Base
  attr_accessible :expense, :income, :name, :email, :address, :phone, :city, :state, :zip, :website

  belongs_to :user
  #has_many :employees yet to be added
  has_many :customers
  has_many :jobs, through: :customers
  has_many :bids, through: :customers
  has_many :invoices, through: :customers

  validates_presence_of :name

  def add_expense(amount)
    self.expense += amount
    self.save
  end 

  def subtract_expense(amount)
    self.expense -= amount
    self.save
  end 

  def add_income(amount)
    self.income += amount
    self.save
  end 

  def subtract_income(amount)
    self.income -= amount
    self.save
  end 

  def gross_profit
    income - expense
  end

  def avg_profit_per_job
    Job.all.count.zero? ? 0 : (gross_profit / Job.all.count)
  end

end
