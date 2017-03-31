class School < ActiveRecord::Base
  # Relationships
  has_many :orders

  # Scopes
  scope :alphabetical, -> { order(:name) }
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  
  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :zip, presence: true, uniqueness: { case_sensitive: false }
  validates_presence_of :street_1
  validates_numericality_of :min_grade, only_integer: true, greater_than_or_equal_to: 0
  validates_numericality_of :max_grade, only_integer: true, greater_than_or_equal_to: :min_grade

  # Other methods
  def destroy_no_order?
    return self.orders.first.blank?
  end
end
