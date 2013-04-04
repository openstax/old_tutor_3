# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

class SectionBlock < BlockBase

  html_element :section
  html_element :heading
  html_element :body

  attr_accessor :heading
  attr_reader   :captured_block

  def initialize(template, &block)
    @template = template
    @block    = block

    section_class_attr_add "section-block-section"
    heading_class_attr_add "section-block-heading"
    body_class_attr_add    "section-block-body"
  end

  def heading=(string)
    raise "SectionBlock heading cannot be reassigned once initialized" \
      if @heading
    @heading = string
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