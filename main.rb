require './nodes'
require './regex'
require './parser'

module DOMParser

  class Main

    class << self

      def run(filename)
        nodes = Parser.parse(filename)
        Parser.render(nodes)
      end

    end

  end

end


DOMParser::Main.run('test.html')