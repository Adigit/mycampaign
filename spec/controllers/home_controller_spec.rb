require 'spec_helper'

describe HomeController do
	describe "GET #campaign" do 
		it "renders the campaign template" do 
			get :campaign
			expect(response).to render_template("campaign")
		end
	end
	
	describe "GET #index" do
		describe "user logged in but session is not set" do 
		before(:each) do
			@user = FactoryGirl.create(:user)
			sign_in @user
		end
		it "renders the mobile index template"  do 
			get :index
			expect(response).to redirect_to("/member/campaigns/mobile")
		end
	   end	
		describe "user logged in" do
			before(:each) do 
				@user = FactoryGirl.create(:user)				
				sign_in @user
			end
			it "renders the web index template" do 
				get :index
				expect(response).to redirect_to("/member/campaigns/web")
			end
		end
		describe "user logged in and session variable are also set" do
			before(:each) do
				@user = FactoryGirl.create(:user)
				sign_in @user
				h = {}
				h["type"] = 'website'
				session["next_path_credentials"] = h
			end
			it "renders web index template" do
				get :index
				expect(response).to redirect_to("/member/campaigns/web")
			end
		end
		describe "user not logged in" do 
			it "renders home index template" do
				get :index
				expect(response).to render_template("index")
			end
		end
	end

	describe "send code via email" do
		before(:each) do
			#user = FactoryGirl.create(:user)
			@user = mock_model(User)
		end
		it "checks whether email system is working fine or not" do 
			post :send_code_via_email
			User.stub!(:find).with(5).and_return(@user)
			expect(response).should == 'sent' 
		end
	end

	describe "GET #setup" do 
		describe "widget setup" do
			it "renders the setup template" do 
				get :setup
				expect(response).to render_template("setup")
			end
		end

		describe "web campaign setup" do
			it "renders setup template" do
				get :setup, :params => {:type=>'website',:website=>'www.socialappshq.com',:mobile=>"", :email=>'aditya@socialappshq.com'}
				expect(response).to render_template("setup")
			end
		end
	end


	describe "GET #create_widget" do 
		describe "create website" do 
			it "create website widget" do
				post :create_widget, :params => {:type => 'website'}			
				expect(response.body).should == 'true'
			end
		end

		describe "create mobile" do 
			it "create mobile widget" do
				post :create_widget, :params => {:type => 'mobile'}
				expect(response.body).should == 'true'
			end
		end
	
		describe "create widget" do 
			it "create widget request with no type param" do
				post :create_widget, :params => {:type => ''}
				expect(response.body).should == 'false'
			end
		end
	
		describe "create website feedback widget" do 
			it "create feedback widget" do 
				post :create_widget, :params => {:type=>"website", :user_id=>1, :camp_id=>1, :widget_type =>"feedback"}
				expect(response.body).should == 'true'
			end
		end
	end
end
