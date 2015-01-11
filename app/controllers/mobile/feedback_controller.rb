class Mobile::FeedbackController < ApplicationController

  def intro

  end

  def index

    if !params[:id].blank?
      @campaign = MobileFeedback.find_by_mobile_campaign_id(params[:id])

      if !@campaign.blank?
        mobile_campaign = MobileCampaign.find_by_id(params[:id])
        @form_fields, @radio_opt = compute_fields_and_options(params,@campaign, mobile_campaign)
      end
    else
      flash[:notice] = "This campaign does not exist"
    end

    render :layout => false
  end
	
	def email_check(params)
      if !params.blank? && !params[:signup_form].blank?
         entry = FormFieldEntry.find_by_model_id_and_model_name_and_email(params[:signup_form][:model_id],params[:signup_form][:model_name],params[:signup_form][:email])
         if !entry.blank?
            return "This email id is already registered!!"
         end
      else
         app_data = params[:signup_form][:model_name].constantize.find_by_fb_sig_page_id_and_fb_sig_app_id(params[:post][:fb_sig_page_id],params[:post][:fb_sig_app_id])
         if !app_data.blank?
            max = app_data.max_entries
            entry = FormFieldEntry.find_all_by_model_id_and_model_name_and_email(params[:signup_form][:model_id],params[:signup_form][:model_name],params[:signup_form][:email])
            if !entry.blank? && max <= entry.size
               return "You have entered maximum allowed entries!!"
            end
         end
      end
      return 0
   end


  # record data from feedback form
  def record_data_in_form_fields_entries
		is_allowed=0

		if (!params.blank? && !params[:new].blank?)
			if params[:signup_form][:email].blank?
				render :text => "<span class=\"response_status\">Email can't be blank.</span>", :layout => "fb_iframe_tab"
				return
			end
			is_allowed =  email_check(params)
				logger.debug ">>>>> is_allowed >>> #{is_allowed.inspect}"
				data = params[:signup_form][:model_name].constantize.find_by_id(params[:signup_form][:model_id])

				if !data.blank?
			if is_allowed == 0
				
      	  camp = data.mobile_campaign
				if !camp.blank?
					form_fields = FormField.find_by_model_name_and_model_id_and_campaign_id(params[:signup_form][:model_name],data.id,camp.id)
					if !form_fields.blank?
						entry = FormFieldEntry.find_by_form_field_id_and_email(form_fields.id,params[:signup_form][:email])
							entry_data = Hash.new
							params[:new].each do |k,v|
								entry_data[k] = v if k != 'data'
							end
#=begin							
							if !params[:new][:from_id].blank?
								obj = FormFieldEntry.connection.execute("insert into form_field_entries(created_at, updated_at,form_field_id,model_name,model_id,campaign_id,email,entry_data,from_id) values(now(), now(), #{form_fields.id},'#{params[:signup_form][:model_name]}',#{params[:signup_form][:model_id]},#{camp.id},#{FormFieldEntry.sanitize(params[:signup_form][:email])},#{FormFieldEntry.sanitize(entry_data.to_json)},#{params[:new][:from_id]})")
								MobileCampaign.connection.execute("update mobile_campaigns set leads = leads + 1 where model_name = '#{params[:signup_form][:model_name]}' and model_id = #{params[:signup_form][:model_id]}")
							else
								obj = FormFieldEntry.connection.execute("insert into form_field_entries(created_at, updated_at,form_field_id,model_name,model_id,campaign_id,email,entry_data) values(now(), now(), #{form_fields.id},'#{params[:signup_form][:model_name]}',#{params[:signup_form][:model_id]},#{camp.id},#{FormFieldEntry.sanitize(params[:signup_form][:email])},#{FormFieldEntry.sanitize(entry_data.to_json)})")
								MobileCampaign.connection.execute("update mobile_campaigns set leads = leads + 1 where model_name = '#{params[:signup_form][:model_name]}' and model_id = #{params[:signup_form][:model_id]}")
							end
#=end
=begin
							obj = FormFieldEntry.new
							obj.created_at = Time.now
							obj.updated_at = Time.now
							obj.form_field_id = form_fields.id
							obj.model_name = params[:signup_form][:model_name]
							obj.model_id = params[:signup_form][:model_id]
							obj.campaign_id = camp.id
							obj.email = params[:signup_form][:email]
							obj.entry_data = FormFieldEntry.sanitize(entry_data.to_json)
							if !params[:new][:from_id].blank?
									  obj.from_id = params[:new][:from_id]
							end
							obj.save
=end
=begin
							h= Hash.new
							h['1'] = 'test'
							test = FormFieldEntry.new(:form_field_id => 2, :model_name => 'MobileCoupon' , :model_id => 3, :campaign_id => 3, :entry_data => '"#{h.to_json}"', :email => 'abcc@gmail.com')
								test.save
=end
							if !params[:new][:data].blank?
                			entry = FormFieldEntry.find_all_by_model_name_and_model_id(params[:signup_form][:model_name],params[:signup_form][:model_id])
			               if !entry.blank?
          			        entry = entry.last
	                 		   entry.update_attribute(:data, params[:new][:data])
   			             end
            			 end
					end
				end
			end
			end
			if !params[:signup_form].blank? && !params[:signup_form][:model_name].blank? && params[:signup_form][:model_name] == "MobileCoupon"
				render :partial => "/mobile/coupon/coupon", :locals =>{:data => data, :message => is_allowed} , :layout => false
			return
			else
		      render :text => "<span class=\"response_status\">Submission Successful!!</span>", :layout => false
	   	end
		end
    return
	end

end
