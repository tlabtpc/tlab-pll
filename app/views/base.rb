module Views
  class Base < Fortitude::Widget
    include Views::Widgets::Helpers

    doctype :html5

    def fa_icon(fa_icon_name, *classes)
      i(class: "fa fa-#{fa_icon_name} #{classes.join(' ')}")
    end

    private

    def set_progress_bar!(index:)
      content_for :progress_bar do
        div class: "progress-bar progress-bar--#{index}"
      end
    end

    def back_button(url, options = {})
      link_to url, options.merge(class: "button button--back") do
        fa_icon 'arrow-left'
        span 'BACK'
      end
    end

    def row(classes=[], expanded: true, &block)
      classes = CssClasses.new(classes, ("expanded" if expanded), "row")
      div class: classes.to_s, &block
    end

    def columns(classes=[], small: 12, medium: nil, large: nil, &block)
      classes = CssClasses.new(
        classes,
        "columns",
        ("small-#{small}" if small.present?),
        ("medium-#{medium}" if medium.present?),
        ("large-#{large}" if large.present?)
      )
      div class: classes.to_s, &block
    end
    alias :column :columns
  end
end
