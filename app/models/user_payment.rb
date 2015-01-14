class UserPayment
	include Mongoid::Document
  #belongs_to :payment_plan
  belongs_to :user

end
