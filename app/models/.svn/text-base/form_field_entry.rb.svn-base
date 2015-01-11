class FormFieldEntry < ActiveRecord::Base
  belongs_to :form_field
  serialize :entry_data
  #acts_as_polymorphic_paperclip
  after_create :send_web_coupon_email
  after_create :send_mobile_coupon_email
  after_create :send_web_feedback_info

  def send_web_coupon_email
    logger.debug "in send_web_coupon_email start"
    if self.model_name == 'WebCoupon'
      coupon_details = WebCoupon.find_by_web_campaign_id(self.campaign_id)
      subject = "Coupon Code : #{coupon_details.coupon_title}"
      end_date = "#{coupon_details.good_until_date}"
      end_time = "#{coupon_details.good_until_hour}"
      path = coupon_details.redirect_url
      if path.blank?
        if !self.entry_data.blank?
         _data = JSON.parse(self.entry_data)
            if !_data["site_loc"].blank?
              path = _data["site_path"]
          end
      end
   end
      to_user = {:email => email,:link => path ,:ccode => coupon_details.coupon_code,:sub => subject, :end_date => end_date, :end_time =>end_time,:send_name => coupon_details.email_name,:send_email => coupon_details.email_address}
      begin
        UserMailer.send_coupon_code(to_user).deliver
      rescue Exception=>e
        logger.debug "send_coupon_email -> Error -> #{e.to_s}"
      end
    end
  end

  def send_web_feedback_info
    if self.model_name == 'WebFeedback'
      if self.model_name == 'WebFeedback'
        coupon_details = WebFeedback.find_by_web_campaign_id(self.campaign_id)
        if !coupon_details.blank?
          to_user = Hash.new
          begin
            if !coupon_details.send_to_email.blank?
              to_user["send_email"] = coupon_details.send_to_email
              _entry_data = JSON.parse(self.entry_data)
              logger.debug "In send_web_feedback_info function after coupon_details.send_to_email -> _entry_data = #{_entry_data.inspect}"
              to_user["name"] = _entry_data["name"] if !_entry_data["name"].blank?
              to_user["email"] = _entry_data["email"]
              to_user["message"] = _entry_data["message"] if !_entry_data["message"].blank?
              to_user["rating"] = _entry_data["rating"] if !_entry_data["rating"].blank?
              to_user["mobile"] = _entry_data["mob_num"] if !_entry_data["mob_num"].blank?
              to_user["category"] = _entry_data["category"] if !entry_data["category"].blank?
              to_user["image_src"] =  "#{SITE_URL}/web/load/send_image_url?id=#{self.id}" if !self.img_data.blank?
              _browser_data = JSON.parse(_entry_data["browser_data"])
              to_user["browser_name"] =  _browser_data["browser_name"]
              to_user["full_version"] = _browser_data["full_version"]
              to_user["major_version"] = _browser_data["major_version"]
              to_user["app_name"] = _browser_data["app_name"]
              to_user["user_agent"] = _browser_data["user_agent"]
              to_user["call_from_path"] = _browser_data["call_from_path"]
              logger.debug "In send_web_feedback_info function -> to_user = #{to_user.inspect}"
              begin
               UserMailer.send_feedback(to_user).deliver
              rescue Exception=>e
                logger.debug "Error while sending feedback details via send_web_feedback_details -> #{e.to_s}"
              end
            end
          rescue Exception=>e
            logger.debug "Error in orgainzing data -> #{e.to_s}"
          end
        end
      end
    end
  end

  def send_mobile_coupon_email
    if self.model_name == 'MobileCoupon'
      logger.debug "In mobile ocupon conditon in form field entry"
      coupon_details = MobileCoupon.find_by_mobile_campaign_id(self.campaign_id)
      subject = "Coupon Code : #{coupon_details.main_message}"
      end_date = "#{coupon_details.good_until_date}"
      end_time = "#{coupon_details.good_until_hour}"
      to_user = {:email => email,:ccode => coupon_details.coupon_code,:sub => subject, :end_date => end_date, :end_time =>end_time}
      logger.debug "In mobile ocupon conditon in form field entry > to_user = #{to_user.inspect}"
      begin
        Notifier.deliver_send_mobile_coupon_code(to_user)
      rescue Exception=>e
        logger.debug "send_mobile_coupon_email -> Error -> #{e.to_s}"
      end
    end
  end

end

