module Layouts
  class Admin < Layouts::Base
    include do
      def head
        csrf_meta_tag
        super
      end

      def body
        div do
          header
          div :id => 'page' do
            div :id => 'main', :class => 'main' do
              flash
              div :id => 'content' do
                content
              end
            end
            div :id => 'sidebar', :class => 'right' do
            end
          end
        end
      end

      def header
        render :partial => 'layouts/admin/header'
      end

      def stylesheets
        stylesheet_link_tag :admin
      end

      def javascripts
        javascript_include_tag :admin
      end
    end
  end
end
