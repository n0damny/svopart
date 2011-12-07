class Product < ActiveRecord::Base
  default_scope :order => 'title'
  validates :title, :producer, :model, :print_tech, :description, :presence => true  #:color, :compatibility, :capacity,
  #validates :weight, :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  has_attached_file :image,
    :styles => {:thumb => '95x95>', :medium => '170x170>', :large => '1024x1024>' },
    :default_style => :thumb,
    :url => "/images/pclip/:class/:attachment/:id/:style/:basename.:extension",
    :path => ":rails_root/public/images/pclip/:class/:attachment/:id/:style/:basename.:extension"
  
  has_many :line_items
  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  has_many :templates
  before_destroy :ensure_not_referenced_by_any_template


  define_index do
    indexes title
    indexes producer
    indexes model
  end

  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
  def ensure_not_referenced_by_any_template
    if templates.count.zero?
      return true
    else
      errors.add(:base, 'templates present')
      return false
    end
  end
end
