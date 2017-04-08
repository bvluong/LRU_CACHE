require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(key)
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    eject! if count == @max
    @map.set(key,val)
    @store.append(key,val)
    val
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
      @store.remove(link)
      @store.append(link, @map.get(link))
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    first_item = @store.first
    @store.remove(first_item.key)
    @map.delete(first_item.key)
  end
end
