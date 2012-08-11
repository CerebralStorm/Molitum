class JobExpense < ActiveRecord::Base
  attr_accessible :job_id, :category, :description, :cost

  belongs_to :job

  validates :job_id, presence: true
  validates :category, presence: true
  validates :cost, numericality: true, presence: true

  CATEGORIES = ['Demolition', 'Framing', 'Tile', 'Finish Work', 'Plumbing', 'Electrical', 'Other']
end
