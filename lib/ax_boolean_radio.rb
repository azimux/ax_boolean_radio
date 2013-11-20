module AxBooleanRadio
  class Engine < Rails::Engine
    config.autoload_paths << File.expand_path("..", __FILE__)

    initializer "ax_boolean_radio" do
      #requiring this so that overrides of brh_translator and brh_translation_wrapper
      #aren't clobbered by unloading/loading in development mode.

      require 'azimux/boolean_radio_helper'

      [ActionView, ActionController].each do |c|
        c::Base.instance_eval { include Azimux::BooleanRadioHelper }
      end
    end
  end
end
