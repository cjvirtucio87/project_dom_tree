


tags = []

File.readlines('test.html').each do |line|
  tags.concat line.scan(DOMReader::RegEx::TAGS)
end


def make_type_node(tag)
  if type_match = DOMReader::RegEx::TYPES.match(tag)
    type_match.captures[0]
  end
end

def make_content_node(tag)
  if content_match = DOMReader::RegEx::CONTENT.match(tag)
    ContentNode.new(content_match.captures[0])
  end
end

def make_attribute_node(tag)
  if attributes_match = DOMReader::RegEx::ATTRIBUTES.match(tag)
    AttributesNode.new(*(attributes_match.captures))
  end
end

def make_nodes(tag)
  type = make_type_node(tag)
  content = make_content_node(tag)
  attributes = make_attribute_node(tag)
  [type,content,attributes]
end

tag_nodes = tags.map do |tag|
  nodes = make_nodes(tag)
  if nodes[0]
    TagNode.new(*nodes)
  else
    nil
  end
end



tag_nodes.each do |tag|
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