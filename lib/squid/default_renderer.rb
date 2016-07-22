module Squid
  # The default renderer for Plotter instances.
  # To customize rendering, subclass this class and override the applicable methods.
  class DefaultRenderer

    def self.column(pdf:, x:, y:, w:, h:)
      pdf.fill_rectangle [x, y], w, h
    end
    def column(pdf:, x:, y:, w:, h:)
      self.class.column(pdf: pdf, x: x, y: y, w: w, h: h)
    end

    def self.legend_box(pdf:, x:, y:, w:, h:)
      pdf.fill_rectangle [x, y], w, h
    end
    def legend_box(pdf:, x:, y:, w:, h:)
      self.class.legend_box(pdf: pdf, x: x, y: y, w: w, h: h)
    end

    # Render a text label for a value on the y-axis.
    # The `index` parameter is not used by default,
    # but is included if you want to use it to customize the rendering.
    def self.axis_label(pdf:, index:, label:, x:, y:, w:, h:, align:)
      options = axis_label_text_options.merge height: h, width: w, at: [x, y], align: align
      pdf.text_box label, options
    end
    def axis_label(pdf:, index:, label:, x:, y:, w:, h:, align:)
      self.class.axis_label(pdf: pdf, index: index, label: label, x: x, y: y, w: w, h: h, align: align)
    end

    # Render the tick-mark & label for a category on the x-axis.
    # The `label_it` parameter tells us whether we’re expected to render the text label.
    # The `index` parameter is not used by default,
    # but is included if you want to use it to customize the rendering.
    def self.category_label(pdf:, index:, label_it: true, label:, x:, y:, w:, h:)
      # Render a tick-mark for a category on the x-axis.
      pdf.stroke_vertical_line y, y - 2, at: x + w/2
      if label_it
        # Render a text label for a category on the x-axis.
        padding = 2
        options = self.axis_label_text_options.merge height: h, align: :center, leading: -3, disable_wrap_by_char: true
        options = options.merge(width: w - (2 * padding), at: [x + padding, y])
        pdf.text_box label, options
      end
    end
    def category_label(pdf:, index:, label_it: true, label:, x:, y:, w:, h:)
      self.class.category_label(pdf: pdf, index: index, label_it: label_it, label: label, x: x, y: y, w: w, h: h)
    end

    # HELPERS

    def self.axis_label_text_options
      options = {}
      options[:size] = 8
      options[:valign] = :center
      options[:overflow] = :shrink_to_fit
      options
    end

  end
end
