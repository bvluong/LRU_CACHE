require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList

  include Enumerable

  def initialize
    @sentinel = Link.new
    @sentinel.next = @sentinel
    @sentinel.prev = @sentinel
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel.next
  end

  def last
    @sentinel.prev
  end

  def empty?
    first == @sentinel
  end

  def get(key)
    self.each {|node| return node.val if node.key == key }
    nil
  end

  def include?(key)
    return false if empty?
    self.any? {|node| node.key == key}
  end

  def append(key, val)
    node = Link.new(key,val)
    node.next = @sentinel
    node.prev = last
    last.next = node
    @sentinel.prev = node
  end

  def update(key, val)
    return false if empty?
    self.each {|node| node.val = val if node.key == key}
  end

  def remove(key)
    self.each { |node| node.remove if node.key == key }
  end

  def each
    variable = @sentinel
    until variable.next == @sentinel
      variable = variable.next
      yield(variable)
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
