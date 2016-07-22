# The custom renderer can be used to change the appearance of the axis labels.
# For the y-axis, the <code>.axis_label</code> method on your renderer is called.
# For the x-axis, the <code>.category_label</code> method on your renderer is called.
#
# Here a custom renderer object decreases the font size at each step on the y-axis,
# and the x-axis labels that would normally be skipped are instead rendered in pale grey.
#
filename = File.basename(__FILE__).gsub('.rb', '.pdf')
Prawn::ManualBuilder::Example.generate(filename) do
  class MyAxisRenderer < Squid::DefaultRenderer
    def self.axis_label(pdf:, index:, label:, x:, y:, w:, h:, align:)
      pdf.text_box label, {height: h, width: w, at: [x, y], align: align,
        size: 6 + (index * 2), valign: :center}
    end
    def self.category_label(pdf:, index:, label_it: true, label:, x:, y:, w:, h:)
      unless label_it
        save_color = pdf.fill_color
        pdf.fill_color "aaaaaa"
      end
      pdf.text_box label, {height: h, width: w - 4, at: [x + 2, y],
        align: :center, valign: :center, size: 8}
      pdf.fill_color save_color unless label_it
    end
  end
  data = {views: {2012 => 63, 2013 => 182, 2014 => 46, 2015 => 134, 2016 => 103}}
  chart data, every: 2, renderer: ::MyAxisRenderer
end
