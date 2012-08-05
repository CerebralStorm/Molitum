class BidItem < ActiveRecord::Base
  attr_accessible :item_type, :cost, :description, :hours, :materials

  validates :bid_id, presence: true
  validates :item_type, presence: true
  validates :cost, numericality: true, presence: true

  belongs_to :bid

  before_save :format_bid_item, :on => :new
  before_save :compute_cost, :on => :new

  def format_bid_item
    self.item_type = item_type.downcase.capitalize
  end

  def compute_cost
    self.cost = (hours * self.bid.hourly_rate) + self.materials
  end
end
