HTML_STRING = 
"<div>
  div text before
  <p>
    p text
  </p>
  <div>
    more div text
  </div>
  div text after
</div>"

def parse_tag(string)
  tag = {}


  /<(\w+)>/.match(string)
  tag[:type] = $1

  if /class=['"]([\w\s\-]+)['"]/.match(string)
    tag[:class] = $1.split(' ')
  end

  if
    /id=['"]([\w\s\-]+)['"]/.match(string)
    tag[:id] = $1
  end

  if 
    /name=['"]([\w\s\-]+)['"]/.match(string)
    tag[:name] = $1
  end

  tag
end


def parse_html(string)
  html = {}
  tags = string.scan(/\<\/*\w+\>/)
  text_nodes = string.scan(/>(\s*.+\s*)</)
  html[:tags] = tags
  html[:text_nodes] = text_nodes
  html
end

def render_html(html)
  tags = html[:tags]
  text_nodes = html[:text_nodes]
  output = ""
  i = 0
  while i < tags.length
    unless text_nodes[i].nil?
      output += "#{tags[i]}#{text_nodes[i][0]}"
    end
    i += 1
  end
  output + tags[-1]
end

html = parse_html(HTML_STRING)
puts render_html(html)