vector = require "hump.vector"


item = require "item"
local itemlist = {}

function itemlist:init()
    self.items = {}
end

function itemlist:addItem(item_type, ritual)
    local nitem = item.Item(item_type, ritual)
    table.insert(self.items, nitem)
end

function itemlist:shuffle()
    local sitems = {}
    while #self.items>0 do
        local index = math.random(1, #self.items)
        table.insert(sitems, self.items[index])
        table.remove(self.items, index)
    end
    self.items = sitems
end

function itemlist:genRandomItemList(count, ritual_count)
    local all = {}
    local items = {}
    for i=1, #item.itemtypes do
        table.insert(all, item.itemtypes[i])
    end
    for i=1, count do
        local index = math.random(1, #all)
        self:addItem(all[index], i<=ritual_count)
        table.remove(all, index)
    end

    --self:shuffle()

    return items
end

return itemlist
