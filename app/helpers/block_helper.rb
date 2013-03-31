module BlockHelper

  def section_block(&block)
    presenter = SectionBlock.new(self, &block)
  end

end