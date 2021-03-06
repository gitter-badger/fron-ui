module UI
  module Behaviors
    # Behavior for handling for selecting
    # one of the children of the component.
    #
    # @author Gusztáv Szikszai
    # @since 0.1.0
    module SelectableChildren
      # Sets up the behavior:
      #
      # * Sets up click event for the selecting
      # * Sets styles for children to have pointer cursor
      #
      # @param base [Fron::Component] The includer
      def self.included(base)
        base.on :click, :on_select
        base.attribute_accessor :multiple, default: false
        base.style '> *' => { cursor: :pointer }
      end

      # Runs when a child is clicked
      #
      # @param event [DOM::Event] The event
      def on_select(event)
        select children.find { |child| child.include?(event.target) }
      end

      # Selects the given child
      #
      # @param child [Fron::Component] The child
      def select(child)
        return unless child
        Array(selected).each { |item| item.remove_class :selected } if selected && !multiple
        child.toggle_class :selected, multiple ? nil : true
        trigger :selected_change
      end

      # Selects the first child
      def select_first
        select children.first
      end

      # Returns the selected child
      #
      # @return [Fron::Component] The child
      def selected
        selected = children.find_all { |child| child.has_class :selected }
        return selected.first if selected.count == 1
        selected
      end
    end
  end
end
