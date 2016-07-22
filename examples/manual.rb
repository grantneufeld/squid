require 'squid'

# special definitions here so that the manual_builder will be able to find the class when called in the renderer examples
class MyCustomRenderer < Squid::DefaultRenderer
  def self.column(pdf:, x:, y:, w:, h:)
    pdf.fill_rounded_rectangle [x, y], w, h, 20
  end
end
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

require 'prawn/manual_builder'
Prawn::ManualBuilder.manual_dir = File.dirname(__FILE__)
Prawn::Font::AFM.hide_m17n_warning = true
Prawn::ManualBuilder::Example.generate 'manual.pdf', skip_page_creation: true do
  load_package 'squid'
end
