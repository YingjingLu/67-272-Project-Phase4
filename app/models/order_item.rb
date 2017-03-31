class OrderItem < ActiveRecord::Base
    # relation macro
    belongs_to :order
    belongs_to :item

    scope :shipped,   ->{ where("shipped_on IS NOT NULL") }
    scope :unshipped, -> { where("shipped_on IS NULL") }

    validate :item_exists_and_active?
    validate :valid_quantity?

    # set shipp_on and inventory level
    def shipped
        corresponding_item = self.item.take
        current_inventory = corresponding_item.inventory_level
        corresponding_item.update_attribute(:inventory_level, (self.quantity + current_inventory)) unless previous.nil?
        self.update_attribute(:shipped_on, date.current.to_date)
        
    def item_exists_and_active?
        all_active_items = Item.active.all.map(&:id)
        if all_active_items.include?(self.item_id)
            return true
        end
        errors.add(:item_id, "is not an active item at the chess store")
        return false
    end

    def valid_quantity?
        if self.quantity >= 0
            return true
        end
        stock_quantity = self.item.inventory_level
        if (self.quantity* -1) > stock_quantity
            errors.add(:quantity, "too much purchase quantity")
            return false
        end
        return true
    end
end
