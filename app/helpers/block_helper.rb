# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

module BlockHelper

  def section_block(&block)
    presenter = SectionBlock.new(self, &block)
  end

end