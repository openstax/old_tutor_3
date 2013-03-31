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

end
