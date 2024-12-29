class LinkedList

  def initialize
    @head = Node.new
  end

  def each
    aux_ptr = @head
    until aux_ptr == nil
      yield aux_ptr.value
      aux_ptr = aux_ptr.next_node
    end    
  end

  def append value

    if @head.value == nil
      @head.value = value
      return
    end

    aux_ptr = @head
    until aux_ptr.next_node == nil
      aux_ptr = aux_ptr.next_node
    end
    aux_ptr.next_node = Node.new value

  end

  def prepend value
    aux_ptr = @head.dup
    @head = Node.new value
    @head.next_node = aux_ptr
  end

  def size
    aux_ptr = @head
    i=0
    until aux_ptr == nil
      i+=1 unless aux_ptr.value == nil
      aux_ptr = aux_ptr.next_node
    end
    i
  end

  def head
    @head
  end

  def tail
    aux_ptr = @head
    until aux_ptr.next_node == nil
      aux_ptr = aux_ptr.next_node
    end
    aux_ptr
  end

  def at index
    i = 0
    aux_ptr = @head
    until i >= index || aux_ptr.next_node == nil
      aux_ptr = aux_ptr.next_node
      i+=1
    end
    aux_ptr
  end

  def pop

    if self.size == 1
      value = @head.value
      @head = Node.new
      return value
    end

    aux_ptr = @head
    i = 0
    until aux_ptr.next_node == nil
      aux_ptr = aux_ptr.next_node
      i+=1
    end

    self.at(i-1).next_node = nil
    aux_ptr

  end

  def contains? value
    aux_ptr = @head
    until aux_ptr == nil
      if aux_ptr.value == value
        return true
      else
        aux_ptr = aux_ptr.next_node
      end
    end
    false
  end

  def find value
    aux_ptr = @head
    i = 0
    until aux_ptr == nil
      if aux_ptr.value == value
        return i
      else
        aux_ptr = aux_ptr.next_node
        i+=1
      end
    end
    nil
  end

  def insert_at value, index

    aux_ptr = self.at(index).dup

    case index
    when 0
      self.prepend value
    when -1, self.size
      self.append value
    else
      self.at(index-1).next_node = Node.new value
      self.at(index).next_node = aux_ptr
    end

  end

  def delete_at index

    case index
    when 0
      if @head.next_node == nil
        self.pop
        return
      end
      @head = @head.next_node
    when -1, self.size
      self.pop
    else
      self.at(index-1).next_node = self.at(index).next_node 
    end
    
  end

  def to_s
    aux_ptr = @head
    string = ""
    until aux_ptr == nil
      string += " [#{aux_ptr.value}] ->"
      aux_ptr = aux_ptr.next_node
    end
    return string += " nil"
  end
end

class Node

  attr_accessor :next_node, :value

  def initialize value=nil
    @value = value 
    @next_node = nil
  end

end