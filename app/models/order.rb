class Order < ActiveRecord::Base
    # relation macros
    has_many :order_items
    belongs_to :user
    belongs_to :school

    # validation
    validates_presence_of :date


    @@AMEX = /^3(4|7)\d{13}$/
    @@DCCB = /^30[0-5]\d{11}$/
    @@DISC = /^6(011\d{12}|5\d{14})$/
    @@MC = /^5[1-5]\d{14}$/
    @@VISA = /^(4\d{12})|(^4\d{15})$/

    def credit_card_type
        if !((@card_num.match(@@AMEX)).nil?)
            return "AMEX"
        elsif !((@card_num.match(@@DCCB)).nil?)
            return "DCCB"
        elsif !((@card_num.match(@@DISC)).nil?)
            return "DISC"
        elsif !((@card_num.match(@@MC)).nil?)
            return "MC"
        elsif !((@card_num.match(@@VISA)).nil?)
            return "VISA"
        else
            return "N/A"
        end
    end


    def validate_school_active
        
    end

    def user_active

    end
end
