module DOMParser

  class Parser

    class << self

      def parse(filename)
        tags = read(filename)
        tag_nodes = tags.map do |tag|
          nodes = make_nodes(tag)
          #Only instantiate the TagNode if the tag actually exists.
          nodes[0] ? DOMParser::Nodes::TagNode.new(*nodes) : nil
        end
      end

      def render(nodes)
        nodes.each do |tag|
          if tag
            puts "Type: #{tag.type}"
            if tag.attributes
              puts "Attributes:"
              puts "... Parent: #{tag.attributes.parent}"
              puts "... Type: #{tag.attributes.type}"
              puts "... Content: #{tag.attributes.content}"
            end
            puts "Content: #{tag.content.data}" if tag.content
            puts
          end
        end
      end

      private
        #Scan each line for tags. 
        #Result needs to be flattened and compacted(remove nil).
        def read(filename)
          File.readlines(filename).map do |line|
            line.scan(DOMParser::RegEx::TAGS)
          end.flatten.compact
        end

        def make_type_node(tag)
          if type_match = DOMParser::RegEx::TYPES.match(tag)
            type_match.captures[0]
          end
        end

        def make_content_node(tag)
          if content_match = DOMParser::RegEx::CONTENT.match(tag)
            DOMParser::Nodes::ContentNode.new(content_match.captures[0])
          end
        end

        #ATTRIBUTES captures all necessary parts in order.
        #Just splat it for the Struct.
        def make_attribute_node(tag)
          if attributes_match = DOMParser::RegEx::ATTRIBUTES.match(tag)
            DOMParser::Nodes::AttributesNode.new(*(attributes_match.captures))
          end
        end

        def make_nodes(tag)
          type = make_type_node(tag)
          content = make_content_node(tag)
          attributes = make_attribute_node(tag)
          [type,content,attributes]
        end

    end

  end

end