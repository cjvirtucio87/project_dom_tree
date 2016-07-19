module DOMParser

  class DOMTree
    attr_reader :root
    
    def initialize(nodes)
      @document = DOMParser::Nodes::TagNode.new("Document",nil,[],[],0)
      @root = DOMParser::Nodes::TagNode.new(nodes[1],@document,[],[],0)
      @document.children.push(@root)
      build_tree(nodes[2..-1])
    end

    def build_tree(nodes)
      depth = 0
      curr = @root
      nodes = make_nodes(nodes,curr,depth)
      nodes = make_attributes(nodes)
    end

    private
      def make_nodes(nodes,curr,depth)
        nodes.map do |node|
          case DOMParser::Parser.inspect(node)
          when :open
            if DOMParser::Parser.inspect(curr.type) == :open
              depth += 1
              curr = make_tag_node(node,depth,curr)
            else
              curr = make_tag_node(node,depth,curr.parent)
            end
          when :close
            if DOMParser::Parser.inspect(curr.type) == :open
              curr = make_tag_node(node,depth,curr.parent)
            else
              depth -= 1
              curr = make_tag_node(node,depth,curr.parent.parent)
            end
          when :text
            depth += 1
            curr = make_tag_node(node,depth,curr)
          end
        end
      end

      def make_attributes(nodes)
        nodes.map do |node|
          make_attribute_node(node) || node
        end
      end

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

      def make_attribute_node(node)
        if DOMParser::RegEx::ATTRIBUTES.match(node.type)
          # type = $1
          # parent = 
          new_attrib = DOMParser::Nodes::AttributesNode.new(attrib_node)
          node.attributes.push(new_attrib)
        end
      end

  end

end
