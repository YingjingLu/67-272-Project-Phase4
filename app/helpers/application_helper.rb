module ApplicationHelper

    def catrgory_selection
        [['Boards','boards'],['Pieces','pieces'],['Clocks','clocks'],['Supplies','supplies']]
    end

    def get_item_options
        Item.all.collect { |m| [m.name, m.id] }
    end
end
