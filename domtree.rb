module DOMParser

  class DOMTree
    
    def initialize(nodes)
      @root = DOMParser::Nodes::TagNode.new(nodes[1],nil,[],[],0)
      build_tree(nodes[2..-1])
    end

    def build_tree(nodes)
      depth = 0
      curr = @root
      nodes.map do |node|
        case DOMParser::Parser.inspect(node)
        when :open
          depth += 1
          new_node = make_tag_node(node,depth,curr)
          curr = new_node
        when :text
          depth += 1
          new_node = make_text_node(node,depth,curr)
          curr = new_node
        when :close
          new_node = make_tag_node(node,depth,curr)
          curr = new_node
          depth -= 1
        end
      end
    end

    private
      def make_tag_node(node,depth,curr)
        new_tag = DOMParser::Nodes::TagNode.new(node,curr,[],[],depth)
        curr.children.push(new_tag)
        new_tag
      end

      def make_text_node(node,depth,curr)
        new_text = DOMParser::Nodes::ContentNode.new(node,curr,depth)
        curr.children.push(new_text)
        new_text
      end

  end

end
