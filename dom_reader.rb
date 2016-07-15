#Pseudocode for dom_reader

#Node will have have children attribute which is an array, and a parent attribute
#Each child is a node and will have children themselves
#Node's children are in order

#plain text is also a node



# HTML_STRING = 
# "<div>
#   div text before
#   <p>
#     p text
#   </p>
#   <div>
#     more div text
#   </div>
#   div text after
# </div>"


# def split_on_tag(string)
#   string.split(/\<\/*[\w\s]+\>/)
# end

# p split_on_tag(HTML_STRING)



Node = Struct.new(:name, :class, :id, :children, :parent)


class DOMReader
  HTML_TAG = /<.*>/

  def initialize
    @dom_string = serialize_dom("test.html")
    @root = Node.new("<!doctype html>", nil, nil, [])
  end


  def serialize_dom(file_name)
    text = File.read(file_name)
  end

  def build_tree
    html_tags = @dom_string.scan(HTML_TAG)
    text_nodes = @dom_string.split(HTML_TAG)

  end


end