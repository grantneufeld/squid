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
  end
end
