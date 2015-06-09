class User < ActiveRecord::Base
	  mount_uploader :avatar, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    # Setup accessible (or protected) attributes for your model

  validates_presence_of   :avatar
  validates_integrity_of  :avatar
  validates_processing_of :avatar
#payment

FIELDS = [:first_name, :last_name, :phone, :company, :credit_cards]
attr_accessor *FIELDS

  def has_payment_info?
  	braintree_customer_id
	end
  def with_braintree_data!
    return self unless has_payment_info?
      braintree_data = Braintree::Customer.find(braintree_customer_id)
      FIELDS.each do |field|
        send(:"#{field}=", braintree_data.send(field))
      end
    self
  end
end
