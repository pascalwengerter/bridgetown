# frozen_string_literal: true

module Bridgetown
  class Layout
    include Convertible

    # Gets the Site object.
    attr_reader :site

    # Gets the name of this layout.
    attr_reader :name

    # Gets the path to this layout.
    attr_reader :path

    # Gets the path to this layout relative to its base
    attr_reader :relative_path

    # Gets/Sets the extension of this layout.
    attr_accessor :ext

    # Gets/Sets the Hash that holds the metadata for this layout.
    attr_accessor :data

    # Gets/Sets the content of this layout.
    attr_accessor :content

    # Gets/Sets the current document (for layout-compatible converters)
    attr_accessor :current_document

    # Gets/Sets the document output (for layout-compatible converters)
    attr_accessor :current_document_output

    # Initialize a new Layout.
    #
    # site - The Site.
    # base - The String path to the source.
    # name - The String filename of the layout file.
    # from_plugin - true if the layout comes from a Gem-based plugin folder.
    def initialize(site, base, name, from_plugin: false)
      @site = site
      @base = base
      @name = name

      if from_plugin
        @base_dir = base.sub("/layouts", "")
        @path = File.join(base, name)
      else
        @base_dir = site.source
        @path = site.in_source_dir(base, name)
      end
      @relative_path = @path.sub(@base_dir, "")

      self.data = {}

      process(name)
      read_yaml(base, name)
    end

    # Extract information from the layout filename.
    #
    # name - The String filename of the layout file.
    #
    # Returns nothing.
    def process(name)
      self.ext = File.extname(name)
    end
  end
end
