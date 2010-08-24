require 'thor'
require 'thor/group'
require 'patches/thor/core_ext/hash'
require 'patches/thor/group/symbolized_options'

module Adva
  module Tasks
    class Cnet
      module Origin
        class Prepare < Thor::Group
          namespace 'adva:cnet:origin:prepare'
          desc 'Prepare origin database by loading cnet source files (e.g. full dump)'
          argument :source,  :required => false
          argument :target,  :required => false
          class_option :pattern, :required => false

          def stage
            Adva::Cnet::Origin::Prepare.new(source, target, :pattern => symbolized_options[:pattern]).run
          end
        end

        module Fixtures
          class Extract < Thor::Group
            namespace 'adva:cnet:origin:fixtures:extract'
            desc 'Extract test fixture data from a sqlite3 database file'
            argument :source, :required => false
            argument :target, :required => false
            argument :prod_ids, :required => false

            def extract
              prod_ids = self.prod_ids ? self.prod_ids.to_s.split(',').map(&:strip) : nil
              Adva::Cnet::Origin::Fixtures::Extract.new(source, target, prod_ids).run
            end
          end
        end

        module Sql
          class Dump < Thor::Group
            namespace 'adva:cnet:origin:sql:dump'
            desc 'Dump a sqlite3 database file to a sql file'
            argument :source, :required => false
            argument :target, :required => false

            def extract
              Adva::Cnet::Origin::Sql.dump(source, target)
            end
          end

          class Load < Thor::Group
            namespace 'adva:cnet:origin:sql:load'
            desc 'Load a sql file to a sqlite3 database'
            argument :source, :required => false
            argument :target, :required => false

            def extract
              Adva::Cnet::Origin::Sql.load(source, target)
            end
          end
        end
      end
    end
  end
end