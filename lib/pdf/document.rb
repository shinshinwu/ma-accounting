module PDF
  class Document

    White    = "ffffff"
    Brown    = "594B3C"
    Teal     = "73CBC4"

    attr_reader :prawn_doc

    def initialize(template_file_path)
      @prawn_doc = ::Prawn::Document.new(template: template_file_path)
      # for some reason this font import currently is not working
      @prawn_doc.font_families.update(
       "Poppins" => {
          regular:      "#{Rails.root}/lib/pdf/fonts/Poppins-Regular.ttf",
          light:        "#{Rails.root}/lib/pdf/fonts/Poppins-Light.ttf",
          medium:       "#{Rails.root}/lib/pdf/fonts/Poppins-Medium.ttf",
          bold:         "#{Rails.root}/lib/pdf/fonts/Poppins-Bold.ttf",
          semi:         "#{Rails.root}/lib/pdf/fonts/Poppins-SemiBold.ttf"
        }
      )
    end

    def render
    end

  end

end
