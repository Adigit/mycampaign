class Web::CouponController < ApplicationController
  def intro

    @title_tag = "Give Coupons to select customers on Website and Mobile App"
    @meta_desc = "Give Coupons to select customers on Website and Mobile App"
    @meta_key = "website coupons, mobile app coupons"
    render :layout => "application"
  end

  def index
    render :layout => false
  end
end
