require 'adva'
require 'globalize'

module Adva
  class Cnet < ::Rails::Engine
    # class Origin < ActiveRecord::Base
    #   establish_connection('cnet_origin')
    # end
    # 
    # class Import < ActiveRecord::Base
    #   establish_connection('cnet_import')
    # end
    # 
    # class Production < ActiveRecord::Base
    #   establish_connection('cnet_production')
    # end
    
    autoload :Connection, 'adva/cnet/connection'
    autoload :Downloader, 'adva/cnet/downloader'
    autoload :Extractor,  'adva/cnet/extractor'
    autoload :Importer,   'adva/cnet/importer'
    autoload :Logger,     'adva/cnet/logger'
    autoload :Origin,     'adva/cnet/origin'
    autoload :Sql,        'adva/cnet/sql'

    include Adva::Engine

    class << self
      def normalize_path(path)
        path.to_s.include?('/') ? path : root.join("db/cnet/#{path}")
      end
    end
  end
end