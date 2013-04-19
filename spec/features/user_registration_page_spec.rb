require 'spec_helper'

describe "new user registration page" do

  it "is loaded when visiting new_user_registration_path" do
    visit new_user_registration_path
    new_user_registration_page_should_be_loaded
  end

  context "successful registration" do
    it "sends user confirmation email upon successful completion of form" do
    end
  end

  context "unsuccessful registrations" do
    it "does not allow two users to have the same email address" do

    end

    it "does not allow passwords of less than 8 characters" do

    end

    it "confirms that the user typed his password correctly" do

    end
  end

end

def new_user_registration_page_should_be_loaded
  page.should have_css('[data-test-page-new-user-registration]')
end
