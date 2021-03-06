require 'osom-normalizr/form_builder'
require 'osom-normalizr/controller_extensions'

module Osom::Normalizr
  class Railtie < Rails::Railtie
    initializer "osom-normalizr.form_helper" do
      ActionView::Base.send :include, FormHelper
    end

    config.to_prepare do
      ApplicationController.send(:include, Osom::Normalizr::ControllerExtensions)
    end
    
    config.before_initialize do
      config.action_view.field_error_proc = Proc.new { |html_tag, instance| "#{html_tag}".html_safe }
    end
  end
end
