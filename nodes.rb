module DOMReader
  
  module Nodes

    TagNode = Struct.new(:type,:content,:attributes)
    
    AttributesNode = Struct.new(:parent,:type,:content)
    
    ContentNode = Struct.new(:data)

  end

end