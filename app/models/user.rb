class User < ActiveRecord::Base
    # relation macros
    has_many :orders
end
