module Adva
  class Cnet
    class Connection
      attr_reader :connection
      
      def initialize(connection, options = {})
        @connection = connection
        # set up link if options[:with_link]
      end
      
      def config
        connection.instance_variable_get(:@config)
      end

      def load(path, options = {})
        Sql.load(path, self, options)
      end
      
      def clear!
        execute("TRUNCATE #{tables.join(',')} RESTART IDENTITY")
      end
      
      def prepare(source, options = {})
        Origin::Prepare.new(source, self, options).run
      end
      
      def count(table_name)
        select_values("SELECT COUNT(*) FROM #{table_name}").first.to_i
      end

      def insert(table_name, row, options = {})
        connection.execute("INSERT INTO #{table_name} VALUES (#{quote(row).join(', ')})")
      end
      
      def with_encoding(encoding)
        transaction do
          set_encoding(encoding)
          yield
          reset_encoding
        end
      end
      
      def set_encoding(encoding)
        execute "SET CLIENT_ENCODING TO '#{encoding}'"
      end
      
      def reset_encoding
        execute "RESET CLIENT_ENCODING"
      end
      
      def respond_to?(method)
        connection.respond_to?(method) || super
      end
      
      def method_missing(method, *args, &block)
        return super unless connection.respond_to?(method)
        args[0] = replace_bound_variables(args[0]) if method.to_s =~ /^select_/
        connection.send(method, *args, &block)
      end
      
      protected

        def replace_bound_variables(query)
          query.is_a?(Array) ? query.first.gsub('?', quote(query.last).join(', ')) : query
        end

        def quote(values)
          values.map { |value| "'#{value}'" }
        end
    end
  end
end