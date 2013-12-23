require 'spec_helper'
require 'gist_img'

describe GistImg::Authentication do

    subject(:auth) do
        GistImg::Authentication.new("spec/support/gist-img")
    end

    describe "#has_token?" do
        it "false when file is not present" do
            temp_auth = GistImg::Authentication.new("spec/support/gist-img-absent")
            temp_auth.should_not be_has_token
        end

        it "true when file is present and is not empty" do
            auth.should be_has_token
        end
    end



end
