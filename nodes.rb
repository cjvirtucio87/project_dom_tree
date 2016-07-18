module DOMParser
  
  module Nodes

    TagNode = Struct.new(:type,:parent,:attributes,:children,:depth)
    
    AttributesNode = Struct.new(:type,:parent,:content,:depth)
    
    ContentNode = Struct.new(:data,:parent,:depth)

  end

end