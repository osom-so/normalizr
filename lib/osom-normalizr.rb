require "osom-normalizr/version"
require "osom-normalizr/railtie" if defined?(Rails)

module Osom
  module Normalizr
    module Rails
      class Engine < ::Rails::Engine
      end
    end
  end
end
