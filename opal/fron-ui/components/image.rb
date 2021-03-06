require 'fron-ui/components/loader'

module UI
  # Component for displaying an image, with
  # a transition after it loads.
  #
  # @author Gusztáv Szikszai
  # @since 0.1.0
  class Image < Fron::Component
    tag 'ui-image'

    component :img, :img
    component :loader, UI::Loader

    style borderRadius: -> { (theme.border_radius * 2).em },
          background: -> { dampen colors.background, 0.05 },
          display: 'inline-block',
          position: :relative,
          'ui-loader' => {
            position: :absolute,
            bottom: 0,
            right: 0,
            left: 0,
            top: 0
          },
          img: { transition: 'opacity 320ms',
                 borderRadius: :inherit,
                 height: :inherit,
                 width: :inherit,
                 opacity: 0,
                 '&.loaded' => { opacity: 1 } }

    # Initializes the component
    # and listens on the load event
    # because it doesn't bubble.
    def initialize
      super
      @img.on(:load) { loaded }
    end

    # Adds the loaded class
    def loaded
      @img.add_class :loaded
      @loader.loading = false
    end

    # Sets the width of the image
    #
    # @param value [Numeric] The width
    def width=(value)
      @style.width = value
    end

    # Sets the height of the image
    #
    # @param value [Numeric] The height
    def height=(value)
      @style.height = value
    end

    # Returns the src attribute of the image
    #
    # @return [String] The attribute
    def src
      @img[:src]
    end

    # Sets the src of the image
    #
    # @param value [String] The URL
    def src=(value)
      return if !value || @img[:src] == value
      @img.remove_class :loaded
      @loader.loading = true
      timeout(320) { @img[:src] = value }
    end
  end
end
