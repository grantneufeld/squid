# You can use the <code>:renderer</code> option to provide a class or object to
# override how some chart elements are drawn.
#
# The <code>.column(pdf:, x:, y:, w:, h:)</code> method will be called on the
# supplied renderer, for column charts.
#
# The pdf parameter supplied to the renderer’s methods is a Prawn::PDF object.
#
# Your custom class or object must inherit from
# <code>Squid::DefaultRenderer</code> to ensure all the expected methods
# (which may expand in future versions) are handled with the default behaviours.
#
# Here a custom class is using a rounded rectangle instead of the Squid
# default plain rectangle:
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  class MyCustomRenderer < Squid::DefaultRenderer
    def self.column(pdf:, x:, y:, w:, h:)
      pdf.fill_rounded_rectangle [x, y], w, h, 20
    end
  end
  data = {views: {2013 => 182, 2014 => 46, 2015 => 134}}
  chart data, renderer: ::MyCustomRenderer
end
