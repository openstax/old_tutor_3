module HtmlContainer

  class Attribute

    def initialize(name, *args)
      self.attr_name = name
      add args
    end

    def add(*args)
      self.attr_string ||= ""
      self.attr_string = [attr_string, args].flatten.join(" ")
      self.attr_string = attr_string.split.uniq.join(" ")
    end

    def to_s
      return "" if attr_string.blank? 
      return "#{attr_name}=\"#{attr_string}\"".html_safe
    end

  protected
    attr_accessor :attr_name
    attr_accessor :attr_string
  end

  class Element
    def method_missing(name, *args)
      if /\A(?<method_name>(?<attr_name>\w+)_attr)=?\z/ =~ name.to_s
        code = %Q{
          def #{method_name}
            @#{method_name} ||= Attribute.new("#{attr_name}")
          end

          def #{method_name}=(string)
            @#{method_name} = Attribute.new("#{attr_name}", string)
          end
        }
        instance_eval code, __FILE__, __LINE__ + 1

        if args.any?
          send name, args
        else
          send name
        end
      else
        return super
      end
    end
  end

  def html_element(element_name)
    code = %Q{
      def #{element_name}_element
        @#{element_name}_element ||= Element.new
      end
    }
    class_eval code
  end
end