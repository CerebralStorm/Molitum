class JobExpense < ActiveRecord::Base
  attr_accessible :job_id, :name, :cost

  belongs_to :job

  validates :job_id, presence: true
  validates :name, presence: true
  validates :cost, numericality: true, presence: true

  before_save :format_job_expense, :on => :new

  def format_job_expense
    self.name = name.downcase.capitalize
  end
end
