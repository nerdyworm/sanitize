require 'spec_helper'

class Thing
  include Sanitize

  sanitize :path, :no

  attr_accessor :path
end

module Sanitize
  describe "a class with Sanitize included" do
    before(:each) do
      @obj = Thing.new
    end

    it "responds to sanitize" do
      @obj.should respond_to :sanitize
    end 

    it "returns the string passed in" do
      str = "string"
      @obj.sanitize(str).should == str
    end

    it "returns an empty string when passed nil" do
      @obj.sanitize(nil).should == ''
    end

    it "converts spaces to dashs" do
      str = "dash me please"
      @obj.sanitize(str).should == "dash-me-please"
    end

    it "keeps file extentions" do
      filename = "index.html"
      @obj.sanitize(filename).should == "index.html"
    end

    it "keeps numbers" do
      filename = "test243.html"
      @obj.sanitize(filename).should == "test243.html"
    end

    it "removes invalid characters" do
      filename = "[lol$%$@].png"
      @obj.sanitize(filename).should == "lol.png"
    end

    it "normalizes the case of strings" do
      str = "LOL"
      @obj.sanitize(str).should == "lol"
    end

    it "keeps directory structure" do
      url = "/blog/home.html"
      @obj.sanitize(url).should == "/blog/home.html"
    end

    it "does not allow any of these cases" do
      str = '~!@#$%^&*()+:;"\'<>,?{}[]|'
      @obj.sanitize(str).should == ''
    end

    describe "magic methods" do
      context "has sanitize :path" do
        it "should respond to sanitize_path" do
          @obj.should respond_to :sanitize_path
        end

        it "does what it is sposed to do" do
          @obj.path = "/inDex.htmL"
          @obj.sanitize_path.should == "/index.html"
          @obj.path.should == "/index.html"
        end

        it "should return nil if the object does not respond to symbol" do
          @obj.should respond_to :sanitize_no
          @obj.sanitize_no.should == nil
        end

        describe "getter with no setter" do
          before :each do
            class Lol
              include Sanitize
              sanitize :cookie

              def cookie
                "Cookie"
              end

            end
            @lol = Lol.new
          end

          it "returns the value" do
            @lol.sanitize_cookie.should == 'cookie'
          end
        end

        describe "using the setter" do
          before :each do
            class Lol
              include Sanitize
              sanitize :cookie

              def cookie
                "Cookie"
              end

              def cookie=(arg)
                "cookie=#{arg}"
              end
            end
            @lol = Lol.new
          end

          it "uses the #= method to set the value" do
            @lol.sanitize_cookie.should == "cookie=cookie"
          end
        end
      end
    end
  end
end
