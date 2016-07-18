module DOMParser

  module RegEx

    OPEN_TAG = /<[^\/]*?>/

    CLOSE_TAG = /<\/.*?>/

    TEXT = /(?<=>)[^><]*(?=<)/

    TEXT_NODE = /[^><]*/

    # TAGS = /<.*>/

    # TYPES = /<(\w+).*>/

    # CONTENT = /<.*>(.*?)<\/.*>/

    # # ATTRIBUTES = /<\w+(.*=.*?)>/

    # ATTRIBUTES = /<(\w+)\s*(\w+)="([^""]+)"/

  end

end