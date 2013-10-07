require 'spec_helper'

describe UserController do

  describe "GET 'registration'" do
    it "returns http success" do
      get 'registration'
      response.should be_success
    end
  end

  describe "GET 'register'" do
    it "returns http success" do
      get 'register'
      response.should be_success
    end
  end

end
