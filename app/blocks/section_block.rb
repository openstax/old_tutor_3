class SectionBlock

  extend HtmlContainer

  html_element :section
  html_element :heading
  html_element :body

  attr_accessor :heading
  attr_reader   :captured_block

  def initialize(template, &block)
    @template = template
    @block    = block

    section_element.class_attr.add "section-section"
    heading_element.class_attr.add "section-heading"
    body_element.class_attr.add    "section-body"
  end

  def to_s
    render_passed_block
    render_partial
  end

  def show_heading?
    heading.present?
  end

protected

  attr_writer :captured_block

  def render_passed_block
    self.captured_block = @template.capture self, &@block
  end

  def render_partial
    h.render :partial => "shared/section", :locals => { :section => self }
  end

  def h
    @template
  end
end