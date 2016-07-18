require './nodes'
require './regex'
require './parser'
require './domtree'
require 'pry'

module DOMParser

  class Main

    class << self

      def run(filename)
        tree = DOMParser::Parser.parse(filename)
        DOMParser::Parser.render(tree)
      end

    end

  end

end


DOMParser::Main.run('test.html')