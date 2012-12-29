module Osom::Normalizr
  module FormHelper
    def form_for(record, options = {}, &proc)
      options[:builder] = OsomFormBuilder
      super(record, options, &proc)
    end

    def fields_for(record_name, record_object = nil, options = {}, &block)
      options[:builder] = OsomFormBuilder
      super(record_name, record_object, options, &block)
    end
  end
end

class OsomFormBuilder < ActionView::Helpers::FormBuilder
  delegate :capture, :content_tag, :tag, to: :@template
  
  def text_field(name,*args)
    args = [{}] if args.first.nil?
    args.first[:size] = nil if args.first[:size].nil?

    args.first[:class] = (args.first[:class] || "").split
    args.first[:class] << "input#{args.first[:type]}" unless args.first[:type].nil?
    args.first[:class] << "inputtext"
    args.first[:class] = args.first[:class].uniq.reverse.join(" ")

    super(name, *args)
  end

  def labelbrinput(label, name, label_args, field_args)
    """
    #{error_for(self.object, name)}
    #{label(name, label, label_args)}
    <br>
    #{text_field(name, field_args)}
    """.html_safe
  end

  def labelinput(label, name, label_args, field_args)
    """
    #{error_for(self.object, name)}
    #{label(name, label, label_args)}
    #{text_field(name, field_args)}
    """.html_safe
  end

  def text_area(name,*args)
    args = [{}] if args.first.nil?
    args.first[:rows] = nil if args.first[:rows].nil?
    args.first[:cols] = nil if args.first[:cols].nil?
    args.first[:class] = "" if args.first[:class].nil?
    args.first[:class] += " textarea"
    super(name, *args)
  end

  def labelbrtextarea(label, name, *args)
    field_args = (args.first && args.first[:input])
    label_args = (args.first && args.first[:label]) || {}
    unless args.first.nil?
      unless args.first.include? :input or args.first.include? :label
        field_args = args.first
      end
    end

    """
    #{error_for(self.object, name)}
    #{label(name, label, label_args)}
    <br>
    #{text_area(name, field_args)}
    """.html_safe
  end

  def submit(name, *args)
    args = [{}] if args.first.nil?
    args.first[:class] = "" if args.first[:class].nil?
    args.first[:class] += " boton"
    super(name, *args)
  end

  def submit!(name, *args)
    args = [{}] if args.first.nil?
    args.first[:class] = "" if args.first[:class].nil?
    args.first[:class] += " importante"
    submit(name, *args)
  end

  def error_for model, field
    if model and model.kind_of?(Object) and model.errors[field].any?
      error = model.errors[field].first
      "<div><span class='error'><strong>Error: </strong><span class='mensaje'>#{error}</span></span></div>".html_safe
    end
  end

  def method_missing(name, *args)
    if (field_type = /^label(br)?([a-z]+)$/.match(name))
      field_args = (args.at(2) && args.at(2)[:input])
      label_args = (args.at(2) && args.at(2)[:label]) || {}
      unless args.at(2).nil?
        unless args.at(2).include? :input or args.at(2).include? :label
          field_args = args.at(2)
        end
      end

      field_args[:type] = field_type[2] unless field_args[:type]

      send("label#{field_type[1]}input", args.at(0), args.at(1), label_args, field_args)
    else
      super(name)
    end
  end
end
