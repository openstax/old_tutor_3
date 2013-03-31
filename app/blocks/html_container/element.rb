module HtmlContainer

  class Element

    def method_missing(method_name, *args)
      if /\A(?<method_basename>(?<attr_name>\w+)_attr)=?\z/ =~ method_name.to_s
        update_instance_methods(method_basename, attr_name)
        call_missing_method(method_name, args)
      else
        return super
      end
    end

  protected

    def update_instance_methods(method_basename, attr_name)
      code = %Q{
        def #{method_basename}
          @#{method_basename} ||= HtmlContainer::Attribute.new("#{attr_name}")
        end

        def #{method_basename}=(string)
          raise "Element Attributes cannot be reassigned once initialized" \
            if @#{method_basename}

          @#{method_basename} = HtmlContainer::Attribute.new("#{attr_name}", string)
        end
      }
      instance_eval code, __FILE__, __LINE__ + 1
    end

    def call_missing_method(method_name, args)
      if args.any?
        send method_name, args
      else
        send method_name
      end
    end

  end

end