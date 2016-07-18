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

    end

  end

end