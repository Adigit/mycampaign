class Web::FeedbackController < ApplicationController
  def intro

    @title_tag = "Feedback Tool, Feedback Widget, Customer Engagement, Mobile App Feedback, Mobile App Engagement"
    @meta_desc = "Use Feedback tool on Website and Mobile App to engage your customers, collect feedback, run surveys "
    @meta_key = "Feedback Tool, Feedback Widget, Customer Engagement, Mobile App Feedback, Mobile App Engagement"

    render :layout => "application"
  end

  def index
    render :layout => false
  end
end

