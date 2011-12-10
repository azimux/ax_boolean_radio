[ActionView, ActionController].each do |c|
  c::Base.instance_eval {include Azimux::BooleanRadioHelper}
end