class ContentController < ApplicationController
  before_filter :index
  def index
    @content = Content.find_by_root_path_and_action_path_and_is_active(params[:controller],"#{params[:action]}#{params[:id]}",1)
    if !@content.blank?
      if !@content.layout.blank?
        render :partial => "content/#{@content.layout}", :locals => {:code => params[:code]}, :layout => "application"
        return
      else
        render :partial => "content/page", :layout => "application"
        return false
      end
    else
      redirect_to :controller => "home", :action => "index"
    end
  end
end
