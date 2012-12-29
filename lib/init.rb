module FormHelper
  def form_for_with_osom(record, options = {}, &proc)
    options[:builder] = OsomFormBuilder
    form_for_without_osom(record, options, &proc)
  end

  def fields_for_with_osom(record_name, record_object = nil, options = {}, &block)
    options[:builder] = OsomFormBuilder
    fields_for_without_osom(record_name, record_object, options, &block)
  end

  alias_method_chain :form_for, :osom
  alias_method_chain :fields_for, :osom
end

class OsomFormBuilder < ActionView::Helpers::FormBuilder
  delegate :capture, :content_tag, :tag, to: :@template
  def text_field(name,*args)
    args = [{}] if args.first.nil?
    args.first[:size] = nil if args.first[:size].nil?
    args.first[:class] = "" if args.first[:class].nil?
    args.first[:class] += " inputtext"
    super(name, *args)
  end

  def labelbrtext(label, name, *args)
    field_args ||= (args.first && args.first[:input])
    label_args = (args.first && args.first[:label]) || {}
    unless args.first.nil?
      unless args.first.include? :input or args.first.include? :label
        field_args = args.first
      end
    end
    "#{label(name, label, label_args)}<br>#{text_field(name, field_args)}".html_safe
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
    field_args ||= (args.first && args.first[:input])
    label_args = (args.first && args.first[:label]) || {}
    unless args.first.nil?
      unless args.first.include? :input or args.first.include? :label
        field_args = args.first
      end
    end
    "#{label(name, label, label_args)}<br>#{text_area(name, field_args)}".html_safe
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
end

ActionView::Base.send :include, FormHelper
