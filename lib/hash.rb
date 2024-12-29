module Prime
  def next_prime(n)
    n += 1
    n += 1 until prime?(n)
    n
  end
  
  def prime?(n)
    return false if n < 2
    (2..Math.sqrt(n)).none? { |i| n % i == 0 }
  end
end

class HashMap

  include Prime
  
  def initialize
    @load_factor = 0.75
    @capacity = 13
    @buckets = Array.new(@capacity) { LinkedList.new }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code ^= (hash_code >> 16)
    hash_code *= 0x85ebca6b
    hash_code ^= (hash_code >> 13)
       
    hash_code
  end

  def code key
    self.hash(key) % @capacity
  end

  def set key, value

    if self.size >= (@capacity * @load_factor)
      data = self.entries.dup
      @capacity = next_prime(@capacity * 2)
      self.clear
      data.each do |pairs|
        code = self.code(pairs[0])
        @buckets[code].append [pairs[0], pairs[1]]
      end
    end

    code = self.code(key)

    @buckets[code].each do |pairs|
      if pairs == nil
        @buckets[code].append([key, value])
        return
      elsif pairs[0] == key
        pairs[1] = value
        return
      end
    end

    @buckets[code].append([key, value])


  end

  def get key
    code = self.code(key)
    @buckets[code].each do |pairs|
      if pairs[0] == key
        return pairs[1]
      end
    end
  end

  def has? key
    code = self.code(key)
    @buckets[code].each do |pairs|
      if pairs[0] == key
        return true
      end
    end
    false
  end

  def remove key

    if self.has?(key) == false
      return nil
    end

    code = self.code key
    i = 0
    @buckets[code].each do |pairs|
      if pairs[0] == key
        value = pairs[1].dup
        @buckets[code].delete_at i
        return value
      end
      i+=1
    end
  end

  def size
    i = 0
    @buckets.each do |bucket|
      i+=bucket.size
    end
    i
  end

  def clear
    @buckets = Array.new(@capacity) { LinkedList.new }
  end

  def keys
    keys_list = LinkedList.new
    @buckets.each do |bucket|
      unless bucket == nil
        bucket.each do |pairs|
          keys_list.append pairs[0] unless pairs == nil
        end
      end
    end
    keys_list
  end

  def values
    values_list = LinkedList.new
    @buckets.each do |bucket|
      unless bucket == nil
        bucket.each do |pairs|
          values_list.append pairs[1] unless pairs == nil
        end
      end
    end
    values_list
  end

  def entries
    entries_list = LinkedList.new
    @buckets.each do |bucket|
      unless bucket == nil
        bucket.each do |pairs|
          entries_list.append pairs unless pairs == nil
        end
      end
    end
    entries_list
  end

  def to_s
    @buckets.each {|b| puts b}
  end
end