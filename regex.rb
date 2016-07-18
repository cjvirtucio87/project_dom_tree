module DOMParser

  module RegEx

    OPEN_TAG = /<[^\/]*?>/

    CLOSE_TAG = /<\/.*?>/

    TEXT = /(?<=>)[^><]*(?=<)/

    # TAGS = /<.*>/

    # TYPES = /<(\w+).*>/

    # CONTENT = /<.*>(.*?)<\/.*>/

    # # ATTRIBUTES = /<\w+(.*=.*?)>/

    # ATTRIBUTES = /<(\w+)\s*(\w+)="([^""]+)"/

  end

end