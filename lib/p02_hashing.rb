class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashnum = 0
    self.each_with_index do |ele,idx|
      hashnum += ele.hash*(idx+1)
    end
    hashnum
  end
end

class String
  def hash
    self.chars.map {|ele| ele.ord}.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashnum = 0
    self.to_a.each do |key, value|
      hashnum += key.hash ^ value.hash
    end
    hashnum
  end
end
