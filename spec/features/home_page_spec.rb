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
