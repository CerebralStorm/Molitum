class QuickLink < ActiveRecord::Base
  attr_accessible :link, :name

  belongs_to :user

  validates :name,  presence: true, length: { maximum: 15 }

  before_save :add_http

  def add_http
    self.link = "http://" << self.link
  end
end
