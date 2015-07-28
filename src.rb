class Tag
  attr_reader :parent

  def initialize name, parent=nil
    @name = name
    @children = Array.new
    @parent = parent

    @attrs = Hash.new
    @styles = Hash.new
    @text = String.new
  end
  def tag name
    t = Tag.new(name, self)
    @children.push t
    return t
  end
  def fin
    c = self
    while c.parent
      c = c.parent
    end
    return c
  end
  def pop
    return @parent
  end
  
  def html text
    @text = text
    return self
  end
  def text text
    @text = text
    return self
  end

  def attr k, v
    @attrs[k] = v
    return self
  end
  def klass v
    k = @attrs["class"] ||= ""
    k << "," if k != ""
    k << v
    return self
  end
  def id v
    @attrs["id"] = v
    return self
  end
  def style k,v
    s = @attrs["style"] ||= ""
    s << ";" if s != ""
    s << k + ":" + v.to_s
    return self
  end

  def to_s
    result = "<%s" % @name
    
    @attrs.each do |k,v|
      result += " %s=%s" % [k, v.to_s]
    end
    
    result += ">" + @text

    @children.each do |child|
      result += child.to_s
    end

    return result + "</%s>" % @name
  end
end

def tag name
  return Tag.new name
end

a =
tag("html")
  .tag("div")
    .attr("AS","B")
    .text("hello")
    .pop
  .tag("div")
    .tag("canvas")
      .id("cc")
      .klass("A")
      .klass("B")
      .style("width", 200)
      .style("height", "200px")
  .fin

puts a.to_s
