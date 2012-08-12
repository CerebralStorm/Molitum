class BidItem < ActiveRecord::Base
  attr_accessible :category, :cost, :description, :hours, :materials

  validates :bid_id, presence: true
  validates :category, presence: true
  validates :cost, numericality: true, presence: true

  belongs_to :bid

  before_save :compute_cost, :on => :new

  def compute_cost
    self.cost = (hours * self.bid.hourly_rate) + self.materials
  end
end
