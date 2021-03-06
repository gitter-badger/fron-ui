class Todos < UI::Box
  # Todo Item
  class Item < UI::Container
    # Includes
    include UI::Behaviors::Confirmation
    include UI::Behaviors::Actions
    include Record

    # Extends
    extend Forwardable

    # Tag
    tag 'ui-todo-item'

    # Delegators
    def_delegators :span, :text=, :text
    def_delegators :checkbox, :checked, :checked=

    # Components
    component :checkbox, UI::Checkbox
    component :span, UI::Label, flex: 1
    component :action, UI::Action, action: :confirm_destroy! do
      component :icon, UI::Icon, glyph: 'android-close'
    end

    # Styles
    style fontFamily: -> { theme.font_family },
          padding: -> { theme.spacing.em },
          color: -> { colors.font },
          'ui-checkbox' => {
            height: 1.5.em,
            width: 1.5.em
          },
          '&.done ui-label' => {
            textDecoration: 'line-through'
          }

    on :change, :update

    confirmation :destroy!, 'Are you sure?'

    def initialize
      super
      self[:direction] = :row
    end

    # Destroys the element in the storage
    # and trigger refresh.
    def destroy!
      Todos.storage.remove data[:id]
      trigger :refresh
    end

    # Updates the elemen tin the storage
    # and triggers refresh.
    def update
      Todos.storage.set data[:id], data.merge(done: done?)
      trigger :refresh
    end

    # Renders the element
    def render
      self.checked = data[:done]
      self.text = data[:text]
      toggle_class :done, done?
    end

    alias_method :done?, :checked
  end
end
