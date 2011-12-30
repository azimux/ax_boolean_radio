module Azimux
  module BooleanRadioHelper
    #override this method to place a wrapper around calls to brh_translator
    # the default just calls whatever block is passed to it.
    # if no block is supplied, it acts like brh_translator
    def brh_translation_wrapper *args
      if block_given?
        yield
      else
        brh_last_part_of_key(args[0])
      end
    end

    #override this method to translate keys.  To use rails default
    #translator, "t", do something like
    # Azimux::BooleanRadioHelper.module_eval { def brh_translator *args; t *args; end }
    # in your config.after_initialize block
    # default behavior is just to show the value in English.  So
    # brh_translator "link.Clear" would come out as "Clear"
    def brh_translator *args
      brh_last_part_of_key(args[0])
    end

    private
    def brh_last_part_of_key key
      key.split(".").last
    end

    public
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
        safe_join([
          content_tag(:th),
          content_tag(:th, brh_translation_wrapper(:"yes")),
          content_tag(:th, brh_translation_wrapper(:"no")),
          content_tag(:th),

          capture(&block)
        ])
      end
    end

  end
end
