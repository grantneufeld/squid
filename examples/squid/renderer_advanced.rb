# When changing the appearance of the chart columns, you may also want to
# change the display of the corresponding boxes in the legend. Provide a
# <code>.legend_box</code> method on your renderer for that.
#
# Here a custom renderer object allows the maximum width of the columns to be
# set in the initializer, and applies a gradient fill.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  class MyAdvancedRenderer < Squid::DefaultRenderer
    def initialize(max_width=20)
      @max_width = max_width
    end
    def column(pdf:, x:, y:, w:, h:)
      if w > @max_width
        x += (w - @max_width) / 2
        w = @max_width
      end
      pdf.fill_gradient [x, y], [x, y - h], 'ff0000', '0000ff'
      super
    end
    def legend_box(pdf:, x:, y:, w:, h:)
      pdf.fill_gradient [x, y], [x, y - h], 'ff0000', '0000ff'
      super
    end
  end
  data = {views: {2013 => 182, 2014 => 46, 2015 => 134}}
  chart data, renderer: ::MyAdvancedRenderer.new(50)
end
