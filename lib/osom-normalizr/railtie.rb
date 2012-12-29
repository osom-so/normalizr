require 'osom-normalizr/form_builder'

module Osom::Normalizr
  class Railtie < Rails::Railtie
    initializer "osom-normalizr.form_helper" do
      ActionView::Base.send :include, FormHelper
    end
  end
end
