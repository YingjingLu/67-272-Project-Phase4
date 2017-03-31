class Order < ActiveRecord::Base
    # relation macros
    has_many :order_items
    belongs_to :user
    belongs_to :school
end
