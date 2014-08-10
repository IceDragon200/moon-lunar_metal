class RenderArray < Moon::RenderContainer
  def select!(&block)
    @elements.select!(&block)
    self
  end

  def reject!(&block)
    @elements.reject!(&block)
    self
  end

  def <<(e)
    add(e)
    self
  end

  def push(e)
    add(e)
    self
  end

  def delete(e)
    remove(e)
  end

  def clear
    @elements.each_with_object(nil, &:parent=)
    @elements.clear
  end

  def unshift(e)
    @elements.unshift(e)
    e.parent = self
    self
  end

  def shift
    element = @elements.shift
    element.parent = nil
    element
  end

  def pop
    element = @elements.pop
    element.parent = nil
    element
  end
end
