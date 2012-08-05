class TimeClock < ActiveRecord::Base
  attr_accessible :hours, :minutes, :work_date, :paid, :job_id

  belongs_to :user
  belongs_to :job

  validates :job_id, presence: true
  validates :hours, numericality: true, presence: true
end
