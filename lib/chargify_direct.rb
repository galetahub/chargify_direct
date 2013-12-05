require 'chargify_direct/version'
require 'chargify_direct/api_client'
require 'chargify_direct/api/calls'
require 'chargify_direct/api/sign_ups'

module ChargifyDirect
  if defined? ::ActionView::Helpers::FormTagHelper
    ActionView::Helpers::FormBuilder.send :include, Helpers::FormTagHelper
  end
end
