module PDF
  class Certificate < Document

    def initialize()
      super("#{Rails.root}/lib/pdf/templates/certificate_blank.pdf")
    end

    def render(date, name, module_num)
      self.insert_dynamic_info(date, name, module_num)
      return @prawn_doc.render
    end

  protected

    def insert_dynamic_info(date, name, module_num)

      half_width  = @prawn_doc.bounds.width() / 2

      #fill in date info
      @prawn_doc.bounding_box([65, 291], { width: 100 } ) do
        @prawn_doc.font("Helvetica") do
          @prawn_doc.fill_color(Document::Brown)
          @prawn_doc.text(date, { align: :center, size: 14, style: :bold })
        end
      end

      #fill in user name
      @prawn_doc.bounding_box([255, 600], { width: 200 }) do
        @prawn_doc.font("Helvetica") do
          @prawn_doc.fill_color(Document::White)
          @prawn_doc.text_box(name, { align: :center, valign: :center, style: :bold, size: 19 })
        end
      end

      #fill in module number
      @prawn_doc.bounding_box([550, 71], { width: 100 }) do
        @prawn_doc.font("Helvetica") do
          @prawn_doc.fill_color(Document::Teal)
          @prawn_doc.text("#{module_num}", { align: :center, style: :bold, size: 37 })
        end
      end

      return @prawn_doc
    end

  end

end
