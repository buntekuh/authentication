module ActionView
  module Helpers
      # 
      # Having a presenter for form builder methods allows for easy change to the look and feel of forms throughout the app
      # 
      # @author [buntekuh]
      # 
    class FormBuilderPresenter < BasePresenter

      presents :form_builder

      # 
      # @see ActionView::Helpers::FormHelper#text_field
      def text_field method, options = {}
        v.render partial: 'form_builder/text_field', locals: { f: form_builder, method: method, options: options }
      end

      # 
      # @see ActionView::Helpers::FormHelper#password_field
      def password_field method, options = {}
        v.render partial: 'form_builder/password_field', locals: { f: form_builder, method: method, options: options }
      end

      # 
      # @see ActionView::Helpers::FormHelper#submit
      def submit value, options = {}
        form_builder.submit value, options
      end
    end
  end
end