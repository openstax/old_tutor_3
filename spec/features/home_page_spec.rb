# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

require 'spec_helper'

describe "home page" do

  before :each do
    @visit_path = root_path
  end

  it "is loaded when visiting root_path" do
    visit @visit_path
    page_should_be_loaded 'home'
  end

  it_should_behave_like "account bar: logged in",     @visit_path
  it_should_behave_like "account bar: not logged in", @visit_path
end
