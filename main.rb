require './nodes'
require './regex'
require './parser'
require './domtree'

module DOMParser

  class Main

    class << self

      def run(filename)
        nodes = Parser.parse(filename)
        # Parser.render(nodes)
      end

    end

  end

end


p DOMParser::Main.run('test.html')