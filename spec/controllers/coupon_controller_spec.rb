require 'spec_helper'

describe Web::CouponController do
	describe "POST #edit" do 
		subject {post :edit} 	
		it "renders the edit template" do
			expect(subject).to render_template(:edit)
			expect(subject).to render_template("edit")
			expect(subject).to render_template("coupon/edit")
		end
	end
end
