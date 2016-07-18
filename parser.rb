module DOMParser

  class Parser

    class << self

      def parse(filename)
        file = File.read(filename)
        nodes = read(file)
        DOMParser::DOMTree.new(nodes)
      end

      def inspect(node)
        return :open if open?(node)
        return :close if close?(node)
        return :text if text?(node)
      end

      def render(tree)
        curr = tree.root
        stack = [curr]
        until stack.empty?
          curr = stack.pop
          curr.children.each do |child|
            display(child)
            stack.push(child)
          end
        end
        nil
      end

      private

        def open?(node)
          !!DOMParser::RegEx::OPEN_TAG.match(node)
        end

        def close?(node)
          !!DOMParser::RegEx::CLOSE_TAG.match(node)
        end

        def text?(node)
          !!DOMParser::RegEx::TEXT_NODE.match(node)
        end

        def read(string)
          nodes = string.scan(/.*/).select { |node| !node.empty? }
        end

        def display(node)
          puts "#{node.type.strip}"
          puts "... Parent: #{node.parent.type.strip}"
          puts "... Depth: #{node.depth}"
        end


      # def parse(filename)
      #   tags = read(filename)
      #   tag_nodes = tags.map do |tag|
      #     nodes = make_nodes(tag)
      #     #Only instantiate the TagNode if the tag actually exists.
      #     nodes[0] ? DOMParser::Nodes::TagNode.new(*nodes) : nil
      #   end
      # end

      # def render(nodes)
      #   nodes.each do |tag|
      #     if tag
      #       puts "Type: #{tag.type}"
      #       if tag.attributes
      #         puts "Attributes:"
      #         puts "... Parent: #{tag.attributes.parent}"
      #         puts "... Type: #{tag.attributes.type}"
      #         puts "... Content: #{tag.attributes.content}"
      #       end
      #       puts "Content: #{tag.content.data}" if tag.content
      #       puts
      #     end
      #   end
      # end

      # private
      #   #Scan each line for tags. 
      #   #Result needs to be flattened and compacted(remove nil).
      #   def read(filename)
      #     File.readlines(filename).map do |line|
      #       line.scan(DOMParser::RegEx::TAGS)
      #     end.flatten.compact
      #   end

      #   #Meta-programming to reduce repetition.
      #   [:type,:content,:attribute].each do |name|
      #     define_method("make_#{name}_node") do |tag|
      #       case name
      #       when :type
      #         if type_match = DOMParser::RegEx::TYPES.match(tag)
      #           type_match.captures[0]
      #         end
      #       when :content
      #         if content_match = DOMParser::RegEx::CONTENT.match(tag)
      #           DOMParser::Nodes::ContentNode.new(content_match.captures[0])
      #         end
      #       when :attribute
      #         #ATTRIBUTES captures all necessary parts in order.
      #         #Just splat it for the Struct.
      #         if attributes_match = DOMParser::RegEx::ATTRIBUTES.match(tag)
      #           DOMParser::Nodes::AttributesNode.new(*(attributes_match.captures))
      #         end
      #       end
      #     end
      #   end

      #   def make_nodes(tag)
      #     type = make_type_node(tag)
      #     content = make_content_node(tag)
      #     attributes = make_attribute_node(tag)
      #     [type,content,attributes]
      #   end

    end

  end

end