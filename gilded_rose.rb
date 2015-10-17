module Updater
  def update
    self.quality -= 1 unless [0, 50].include?(self.quality)
    self.sell_in -= 1
  end
end

module AgedBrie
  def quality=(_arg)
    self[:quality] += 1
  end
end

module BackstagePasses
  def quality=(_arg)
    return 0 if self.sell_in == 0
    if self.sell_in <= 5
      self[:quality] += 3
    elsif self.sell_in <= 10
      self[:quality] += 2
    else
      self[:quality] += 1
    end
  end
end

module Sulfuras
  def quality=(_arg)
    DEFAULT_SULFURAS_QUALITY
  end

  def sell_in=(_arg)
    DEFAULT_SULFURAS_QUALITY
  end
end

item_hash = {
  AGED_BRIE => AgedBrie,
  BACKSTAGE_PASSES => BackstagePasses,
  SULFURAS => Sulfuras
}

DEFAULT_SULFURAS_QUALITY = 80.freeze
AGED_BRIE = 'Aged Brie'
BACKSTAGE_PASSES = 'Backstage passes to a TAFKAL80ETC concert'
SULFURAS = 'Sulfuras, Hand of Ragnaros'

def update_quality(items)
  items.each do |item|
    item.extend(item_hash[item.name], Updater)
    item.update
  end
end
#
#     if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
#       if item.quality > 0
#         if item.name != 'Sulfuras, Hand of Ragnaros'
#           item.quality -= 1
#         end
#       end
#     else
#       if item.quality < 50
#         item.quality += 1
#         if item.name == 'Backstage passes to a TAFKAL80ETC concert'
#           if item.sell_in < 11
#             if item.quality < 50
#               item.quality += 1
#             end
#           end
#           if item.sell_in < 6
#             if item.quality < 50
#               item.quality += 1
#             end
#           end
#         end
#       end
#     end
#     if item.sell_in < 0
#       if item.name != "Aged Brie"
#         if item.name != 'Backstage passes to a TAFKAL80ETC concert'
#           if item.quality > 0
#             if item.name != 'Sulfuras, Hand of Ragnaros'
#               item.quality -= 1
#             end
#           end
#         else
#           item.quality = item.quality - item.quality
#         end
#       else
#         if item.quality < 50
#           item.quality += 1
#         end
#       end
#     end
#   end
# end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

# Item.new("Aged Brie", 2, 0)
