# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

module HtmlContainer

  def html_element(element_name)
    code = %Q{
      def #{element_name}_element
        @#{element_name}_element ||= HtmlContainer::Element.new
      end
    }
    class_eval code
  end

end