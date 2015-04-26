module UI
  class Input < Base
    tag 'input[type=text]'

    style padding: -> { "0 #{theme.spacing.em}" },
          borderRadius: -> { theme.border_radius.em },
          fontFamily: -> { theme.font_family },
          color: -> { colors.font },
          height: -> { theme.size.em },
          lineHeight: -> { theme.size.em },
          fontSize: :inherit,
          border: 0,
          '&:focus' => {
            boxShadow: -> { theme.focus_box_shadow },
            outline: :none
          },
          '&::placeholder' => {
            fontWeight: 600
          }
  end
end
