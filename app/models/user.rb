class User < ActiveRecord::Base
  ROLES = %w[ banned client moderator admin ]
  validates :username, :email, :password, :presence => true
  validates :username, :uniqueness => true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable,  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :templates
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :role, :dbirth,
                  :firstname, :city, :phone, :litso, :address1, :metro1, :address2, :metro2, :accnt
                  
  def add_product(product_id)
    current_item = templates.find_by_product_id(product_id)
    if !current_item
      current_item = templates.build(:product_id => product_id)
    end
    current_item
  end

  def role?(base_role)
    if role
      ROLES.index(base_role.to_s) <= ROLES.index(role)
    end
  end
  #def roles
  #  ROLES.reject
  #end

  
end
