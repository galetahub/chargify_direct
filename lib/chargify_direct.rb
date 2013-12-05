require 'chargify_direct/version'
require 'chargify_direct/error'
require 'chargify_direct/api_client'
require 'chargify_direct/helpers/form_tag_helper'

module ChargifyDirect
  if defined? ::ActionView::Helpers::FormTagHelper
    ActionView::Helpers::FormBuilder.send :include, Helpers::FormTagHelper
  end
end
