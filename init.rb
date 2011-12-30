#requiring this so that overrides of brh_translator and brh_translation_wrapper
#aren't clobbered by unloading/loading in development mode.
require 'azimux/boolean_radio_helper'

[ActionView, ActionController].each do |c|
  c::Base.instance_eval {include Azimux::BooleanRadioHelper}
end