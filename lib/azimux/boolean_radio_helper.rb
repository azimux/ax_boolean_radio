module Azimux
  module BooleanRadioHelper
    def invalid_boolean_radio_options?(options)
      valid = [:label, :additional_row_classes]

      options.keys.each do |key|
        if !valid.include? key.to_sym
          return key
        end
      end

      false
    end

    def boolean_radio_for f, field, options = {}
      invalid_option = invalid_boolean_radio_options?(options)
      raise "Invalid boolean radio option: #{invalid_option}" if invalid_option

      options = options.dup
      label = options.delete(:label) || field.to_s.humanize

      raise "unexpected nil f.object_name in boolean_radio_for" unless f.object_name

      tr_classes = "ax_boolean_row"

      if options[:additional_row_classes]
        tr_classes = ([tr_classes] + Array(options[:additional_row_classes])).join(" ")
      end

      tag_name = "#{f.object_name}[#{field}]"

      render :partial => "boolean_radio/boolean_radio_for",
        :locals => {
        :tag_name => tag_name,
        :label => label,
        :builder => f,
        :field => field,
        :options => options,
        :tr_classes => tr_classes
      }
    end

    def boolean_radio_tag object_name, field, checked, options = {}
      if checked
        checked = [true, "true"].include? checked
      end

      checked = false if checked == "false"

      options = options.dup
      label = options.delete(:label) || field.to_s.humanize

      tr_classes = "ax_boolean_row"

      if options[:additional_row_classes]
        tr_classes = ([tr_classes] + Array(options[:additional_row_classes])).join(" ")
      end

      tag_name = "#{object_name}[#{field}]"

      render :partial => "boolean_radio/boolean_radio_tag",
        :locals => {
        :tag_name => tag_name,
        :checked => checked,
        :label => label,
        :options => options,
        :tr_classes => tr_classes
      }
    end

    def boolean_range &block
      content_tag :table do
        [
          content_tag(:th),
          content_tag(:th, axt(:"yes")),
          content_tag(:th, axt(:"no")),
          content_tag(:th),

          capture(&block)
        ].join.html_safe
      end.html_safe
    end

  end
end
