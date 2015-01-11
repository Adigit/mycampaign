class Website < ActiveRecord::Base
  has_many :web_campaigns
  attr_protected :id
end
