module DOMReader

  module RegEx

    TAGS = /<.*>/

    TYPES = /<(\w+).*>/

    CONTENT = /<.*>(.*?)<\/.*>/

    # ATTRIBUTES = /<\w+(.*=.*?)>/

    ATTRIBUTES = /<(\w+)\s*(\w+)="([^""]+)"/

  end

end