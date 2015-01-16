module CommonTool
  #include FbCommonTool
  #include REXML
  include ApplicationHelper

  def compute_fields_and_options(params,data, camp=false)
    radio_opt = Hash.new
		form_fields = Array.new
		if !params.blank? && !data.blank?

      if camp.blank? # for FB campaigns
        camp = FbAppPageMap.find_by_fb_sig_page_id_and_fb_app_id(params[:fb_sig_page_id],data.fb_app_id)
      end

      if !camp.blank?
	      form_fields= FormField.where("model_name = '#{camp.model_name}' and model_id = #{data.id} and campaign_id = #{camp.id} and  display_order != -1").order('display_order').all
        if !form_fields.blank?
          form_fields.each do |f|
            if f.field_type == 'radio' && f.display_order != -1
              opt = CustomSignupAnswer.find_all_by_custom_signup_field_id_and_is_active(f.id,1)
              if !opt.blank?
                radio_opt["#{f.id}"]  = []
                opt.each do |o|
                  radio_opt["#{f.id}"] << o.option_text
                end
              end #if !opt.blank?
            end #if f.field_type == 'radio' && f.display_order != -1
          end #@form_fields.each do
        end #if !@form_fields.blank?
      end #if camp.blank?
    end
    return form_fields,radio_opt
	end

	def find_field_name(name)
    new_name = ""
    if name == 'title'
      new_name = 'Title'
    elsif name == 'company'
      new_name = 'Company'
    elsif name == 'city'
      new_name = 'City'
    elsif name == 'address'
      new_name = 'Address'
    elsif name == 'dob'
      new_name = 'Date Of Birth'
    elsif name == 'country'
      new_name = 'Country'
    elsif name == 'postal_code'
      new_name = 'Postal Code'
    elsif name == 'gender'
      new_name = 'Gender'
    elsif name == 'phone'
      new_name = 'Phone'
    elsif name == 'last_name'
      new_name = 'Last Name'
    elsif name == 'state'
      new_name = 'State'
    elsif name == 'email'
      new_name = 'Email'
    elsif name == 'first_name'
      new_name = 'First Name'
    end
    return new_name
  end

	def insert_or_update_form_field(params,camp_id,conn)
    logger.error ">>>>>> inside or update form field >>>>>"
		FormField.where("display_order = -1").update_all("model_name = '#{params[:post][:model_name]}' and model_id = #{params[:post][:model_id]} and campaign_id = #{camp_id}")
    logger.error ">>>>> after update >>>>> "
    conn = FormField.connection
    if (!params[:form_fields].blank?)
      field_hash = Hash.new
      if !params[:fields_sequence][:predefined].blank?
        pre = params[:fields_sequence][:predefined].split('/')
        pre.each do |p|
          field = p.split('=>')[0]
          order = p.split('=>')[1]
          field_hash["#{field}"]= order
        end
      end
      params[:form_fields].each do |k,v|
        if v=="1"
          if !params[:post][:model_name].blank? && !params[:post][:model_id].blank?
            obj = FormField.find_by_model_id_and_model_name_and_field_name(params[:post][:model_id],params[:post][:model_name],k)
            f_name = find_field_name(k)
            order = field_hash["#{f_name}"]
            if !order.blank?
	            if !obj.blank?
                obj.update_attribute(:display_order,order)
      	      else
                q = "insert into form_fields(model_name,model_id,campaign_id,field_name,required_field,show_on_details_page,display_order) values('#{params[:post][:model_name]}',#{params[:post][:model_id]},#{camp_id},'#{k}',1,1,#{order})"
            	  conn.execute(q)
              end
            end
          end
        end
      end
    end

	end

	def prepare_custom_fields_sequence_hash(params)
    cus_field_hash = Hash.new
		if !params[:fields_sequence][:custom].blank?
      cus = params[:fields_sequence][:custom].split('/')
      cus.each do |c|
        field = c.split('=>')[0]
        order = c.split('=>')[1]
        cus_field_hash["#{field}"] = order
      end
    end
		return cus_field_hash
	end

	def populate_form_fields(params, camp)

    if !camp.blank?
      camp_id = camp.id
      conn = FormField.connection
      logger.error ">>>>> populate form field >>>>>>"
      insert_or_update_form_field(params,camp_id,conn)
      logger.error ">>>>>>> after populate form field >>>>"
      if !params[:fields_sequence][:custom].blank?
        cus_field_hash = Hash.new
        cus = params[:fields_sequence][:custom].split('/')
        cus.each do |c|
          field = c.split('=>')[0]
          order = c.split('=>')[1]
          cus_field_hash["#{field}"] = order
        end
      end
      if !params[:custom].blank?
        cus_data_hash = params[:custom]
        logger.debug "In common  tool -> before sanitize = #{cus_data_hash.inspect}"
        cus_data_hash = User.sanitize(cus_data_hash)
        logger.debug "In common  tool -> After sanitize = #{cus_data_hash.inspect}"
        cus_field_hash.each do |k,v|
          option_value = Array.new
          option_hash = Hash.new
          temp = params[:custom].index(k)
          index = temp.split('_')[2]
          fields_data = params[:custom]
          field_name = fields_data["field_name_"+index]
          field_type = fields_data["field_type_"+index]
          if field_type == 'radio' && !params[:answer].blank?
            params[:answer].each do |k,v|
              option_hash["#{k}"] = v
            end
          end
          if field_type == 'like' && !params[:like_url].blank?
            url = params[:like_url]['url_'+index]
            field_name = "#{field_name}|#{url}"
          end
          if !option_hash.blank?
            option_hash.each do |k,v|
              for i in 0..option_hash.size+1
                if k == "option_text_#{index}_#{i}"
                  option_value << v
                end
              end
            end
          end
          required = fields_data["required_"+index]
          show= fields_data["show_on_detail_page_"+index]
          if required.blank? || required.nil?
            required =0
          end
          show= fields_data["show_on_detail_page_"+index]
          if show.blank? || show.nil?
            show = 0
          end
          obj = FormField.find_by_model_id_and_model_name_and_id(params[:post][:model_id],params[:post][:model_name],index)
          if obj.blank?
            obj = FormField.find_by_model_id_and_model_name_and_field_name(params[:post][:model_id],params[:post][:model_name],field_name)
          end
          if field_type  == 'like'
            fname = field_name.split('|')
            if !fname.blank?
              f = fname[0]
              order = cus_field_hash["#{f}"]
              if order.blank?
                order = -1
              end
            end
          else
            order = cus_field_hash["#{field_name}"]
          end
          if !obj.blank?
            obj.update_attributes(:display_order =>order,:field_name => field_name, :field_type => field_type, :required_field => required, :show_on_details_page => show)
            if field_type == 'radio'
              if !option_value.blank?
                CustomSignupAnswer.update_all("is_active = 0","model_id = #{params[:post][:model_id]} and custom_signup_field_id = #{index}")
                option_value.each do |op|
                  options = CustomSignupAnswer.find_by_model_id_and_custom_signup_field_id_and_option_text(params[:post][:model_id],index,op)
                  if options.blank?
                    options = CustomSignupAnswer.find_by_model_id_and_option_text(params[:post][:model_id],op)
                  end
                  if options.blank?
                    CustomSignupAnswer.connection.execute("insert into custom_signup_answers(created_at,updated_at,model_id,custom_signup_field_id,option_text) values(now(),now(),'#{params[:post][:model_id]}',#{index},'#{op}')")
                  else
                    options.update_attributes(:updated_at => Time.now(), :option_text => "#{op}", :is_active => 1)
                  end
                end
              end
            end
          else
            q = "insert into form_fields(model_name,model_id,campaign_id,field_name,field_type,required_field,show_on_details_page,display_order) values('#{params[:post][:model_name]}',#{params[:post][:model_id]},#{camp_id},#{FormField.sanitize(field_name)},'#{field_type}',#{required},#{show},#{order})"
            conn.execute(q)
            if field_type == 'radio'
              field = FormField.find_by_model_id_and_model_name_and_campaign_id_and_field_name_and_field_type(params[:post][:model_id],params[:post][:model_name],camp_id,field_name,'radio')
              if !field.blank? && !option_value.blank?
                option_value.each do |op|
                  CustomSignupAnswer.connection.execute("insert into custom_signup_answers(created_at,updated_at,model_id,custom_signup_field_id,option_text) values(now(),now(),'#{params[:post][:model_id]}',#{field.id},'#{op}')")
                end
              end
            end
          end
        end
      end
    end #  do nothing if campaign is blank
	end




  def is_mobile()
    if !request.blank? && !request.user_agent.blank?
      if /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.match(request.user_agent) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.match(request.user_agent[0..3])
        return true
      end
    end
    return false
  end

  def record_web_analytics(params)
    begin
      camp_id = params[:campaign_id]
      model_name = params[:model_name]
      model_id = params[:model_id]
      key = "#{camp_id}_#{model_name}_#{model_id}"
      ana = LocalCache.get(WEB_KEY)
      count = LocalCache.get(COUNTER)
      count = !count.blank? ? (count + 1) : 1
      LocalCache.set(COUNTER, count)
      date = Time.now.to_date.to_s
      if !ana.blank? && !ana["#{key}"].blank? && !ana[key][date].blank?
        ana[key][date]["tab_clicks"] += params[:tab_clicks].to_i
        ana[key][date]["views"] += params[:views].to_i
        ana[key][date]["clicks"] += params[:clicks].to_i
        ana[key][date]["leads"] += params[:leads].to_i
        ana[key][date]["continue"] += params[:continue].to_i
      else
        if !ana.blank? && ana.length > 0
          LocalCache.delete(WEB_KEY)
          LocalCache.delete(COUNTER)
          flush_web_analytics_to_db(ana)
          count = 0
        end
        ana = Hash.new if ana.blank?
        ana[key] = { "#{date}" => { "tab_clicks" => params[:tab_clicks].to_i, "views" => params[:views].to_i, "clicks" => params[:clicks].to_i, "leads" => params[:leads].to_i, "continue" => params[:continue].to_i } }
      end
      LocalCache.set(WEB_KEY, ana)
      if !count.blank? && count > 100
        LocalCache.delete(WEB_KEY)
        LocalCache.delete(COUNTER)
        flush_web_analytics_to_db(ana)
        count = 0
      end
    rescue Exception => e
      logger.error $!, $!.backtrace
    end
  end

  def flush_web_analytics_to_db(ana)
    ana.each do |k,v|
      campaign_id = k.split('_')[0]
      model_name = k.split('_')[1]
      model_id = k.split('_')[2]
      # Do not bother for loop, it runs only once. So code followes waterfall flow.
      v.each do |date, analytics|
        logger.debug ">>>> date, >>>> #{date.inspect} >>> analytics >>> #{analytics.inspect}"
        view = model_name != 'WebNotification' ? analytics['tab_clicks'].to_i : analytics['views'].to_i
        click = analytics['clicks'].to_i + analytics['continue'].to_i
        lead = analytics['leads'].to_i
        month = date.split("-")[1].to_i
        year = date.split("-")[0].to_i
        record_exist = WebAnalytic.find_by_model_id_and_model_name_and_web_campaign_id_and_month_and_year(model_id, model_name, campaign_id, month, year)
        if record_exist.blank?
          h = Hash.new
          h[date] = analytics
          WebAnalytic.connection.execute("insert into web_analytics(created_at, updated_at, web_campaign_id, model_name, model_id, day_wise_metric, month, year) values(now(), now(), #{campaign_id}, '#{model_name}', #{model_id}, '#{h.to_json}', #{month}, #{year})")
        else
          metric = JSON.parse(record_exist.day_wise_metric)
          if !metric[date].blank?
            temp = { "tab_clicks" => analytics["tab_clicks"].to_i + metric[date]["tab_clicks"].to_i, "views" => analytics["views"].to_i + metric[date]["views"].to_i, "clicks" => analytics["clicks"].to_i + metric[date]["clicks"].to_i, "leads" => analytics["leads"].to_i + metric[date]["leads"].to_i, "continue" => analytics["continue"].to_i + metric[date]["continue"].to_i}
            metric[date] = temp
          else
            metric[date] = analytics
          end
          WebAnalytic.connection.execute("update web_analytics set updated_at = now(), day_wise_metric = '#{metric.to_json}' where id = #{record_exist.id}")
        end
        WebCampaign.connection.execute("update web_campaigns set updated_at = now(), views = views + #{view}, leads = leads + #{lead}, clicks = clicks + #{click} where id = #{campaign_id}")
      end
    end
  end

=begin
  def authenticator
    facebook_settings = YAML::load(File.open("#{RAILS_ROOT}/config/facebooker.yml"))
    logger.debug facebook_settings.inspect
    client_id = facebook_settings[RAILS_ENV]['app_id']
    secret = facebook_settings[RAILS_ENV]['secret']
    #logger.debug secret.inspect
    @authenticator ||= Mogli::Authenticator.new(client_id, secret, oauth_callback_url)
    #logger.debug @authenticator.inspect
    return @authenticator
  end
=end

  def save_feedback_campaign_mobile(campaign)
    if current_user
      type = campaign.model_name.constantize.new(:mobile_campaign_id => campaign.id,:user_id => current_user.id,
    :header_message => "Survey", :main_message => "Please provide us your valuable inputs. It will just take 1-2 minutes.",
      :first_button_text => "Participate", :second_button_text => "Not Now"
    )
    else
       type = campaign.model_name.constantize.new(:mobile_campaign_id => campaign.id,
    :header_message => "Survey", :main_message => "Please provide us your valuable inputs. It will just take 1-2 minutes.",
      :first_button_text => "Participate", :second_button_text => "Not Now"
    )
    end
    return type
  end


  def save_notification_campaign_mobile(campaign)
    if current_user
    type = campaign.model_name.constantize.new(:is_active => 1, :user_id => current_user.id,
      :mobile_campaign_id => campaign.id,:header_message => "Upgrade to New Version", :main_message => "New Version offers Voice Calls and lot more features",
      :first_button_text => "Upgrade Now", :first_button_link => "http://play.google.com/",:second_button_text => "Not Now"
    )
    else
      type = campaign.model_name.constantize.new(:is_active => 1,
      :mobile_campaign_id => campaign.id,:header_message => "Upgrade to New Version", :main_message => "New Version offers Voice Calls and lot more features",
      :first_button_text => "Upgrade Now", :first_button_link => "http://play.google.com/",:second_button_text => "Not Now"
    )
    end
    return type
  end


  def save_coupon_campaign_mobile(campaign)
    if current_user
    type = campaign.model_name.constantize.new(:mobile_campaign_id => campaign.id,
      :good_until_hour => "11:00 PM", :good_until_timezone => "8.0", :good_until_date => 30.days.from_now,
      :header_message => "20% Off", :main_message => "Get 20% off on all our products. Offer valid till #{30.days.from_now}",
      :first_button_text => "Claim", :second_button_text => "Skip",
      :user_id => current_user.id)
    else
      type = campaign.model_name.constantize.new(:mobile_campaign_id => campaign.id,
      :good_until_hour => "11:00 PM", :good_until_timezone => "8.0", :good_until_date => 30.days.from_now,
      :header_message => "20% Off", :main_message => "Get 20% off on all our products. Offer valid till #{30.days.from_now}",
      :first_button_text => "Claim", :second_button_text => "Skip")
    end
    return type
  end


  def save_feedback_campaign_web(campaign)
    campaign.model_name.constantize.new(:web_campaign_id => campaign.id)
  end


  def save_notification_campaign_web(campaign)
    campaign.model_name.constantize.new(:web_campaign_id => campaign.id)
  end


  def save_coupon_campaign_web(campaign)
    type = campaign.model_name.constantize.new(:web_campaign_id => campaign.id, 
      :good_until_hour => "11:00 PM", :good_until_timezone => "PST", 
      :good_until_date => 30.days.from_now)
    return type
  end
end

