class Admin::HomeController < ApplicationController
#before_filter :authorized_users_for_site
#  protect_from_forgery with: :null_session
skip_before_filter :verify_authenticity_token

  def index
    @nodes = Content.where(is_active: 1)

  end

  def show
    @node = Content.find_by id: params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @node }
    end
  end

  def new
    @node = Content.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @node }
    end
  end

  # GET /nodes/1/edit
  def edit
    @node = Content.find_by id: params[:id]
  end

  def create
    @node = Content.new(params[:node])
    respond_to do |format|
      if @node.save
        flash[:notice] = 'node was successfully created.'
        format.html { redirect_to "/admin/home/index" }
        format.xml  { render :xml => @node,
                      :status => :created, :location => @node }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @node.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def update
    @node = Content.find_by id: params[:id]

    respond_to do |format|
      if @node.update(content_params)
        flash[:notice] = 'node was successfully updated.'
        format.html { redirect_to "/admin/home/index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @node.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @node = Content.find_by id: params[:id]
    @node.is_active=0
    @node.save
    respond_to do |format|
      format.html { redirect_to "/admin/home/index"}
      format.xml  { head :ok }
    end
  end



  def customer_list
    return if request.remote_ip!=LOCAL_IP
    paid_cus = Array.new()
    ups = UserPayment.find(:all, :select=>'user_id', :conditions=>"is_active=1")
    ups.each {|up|
        paid_cus << up.user_id if !up.user_id.blank? && up.user_id!=0
    }

    urs = UserRole.find(:all, :select=> "user_id, admin_id", :conditions=>"user_id in (#{paid_cus.join(',')}) or admin_id in (#{paid_cus.join(',')})")
    urs.each { |ur|
      paid_cus << ur.user_id if !ur.user_id.blank? && ur.user_id!=0
      paid_cus << ur.admin_id if !ur.admin_id.blank? && ur.admin_id!=0
    }

    paid_cus.uniq!

    @users = User.find(:all, :conditions =>"id in (#{paid_cus.join(',')})")
  end


  def mark_email
    if !params[:email].blank?
      list = params[:email].split(',')

      list.each {|l|
        u = User.find_by_email(l)
        next if u.blank?
        up = UserPreference.find_or_initialize_by_user_id(u.id)
        up.update_attributes(:email_type => params[:email_type]||'spam', :email => l)
      }
    end

    render :text => "Updated"
  end

  def integrations

  end

  def instructions
    
  end

  # scraped emails can be put here and you are all set
  def add_email_to_list

    @err = ""
    begin

    if !params[:email].blank?
        EmailList.create(:email_type => params[:email_type], :recipient => params[:email],
                           :priority_order => params[:priority_order], :name => params[:name])
    end

    rescue Exception=>e
      logger.error "add_email_to_list -> #{e.to_s}"
      @err = "#{err}, #{e.to_s}"
    end

    @err = "Updated -> #{@err}"
    render "/admin/home/add_email"
  end

  def add_email_batch_to_list
    err = ""
    if !params[:email].blank?
      list = params[:email].split(',')

      list.each { |l|
        begin
          EmailList.create(:email_type => params[:email_type], :recipient => l,
                           :priority_order => params[:priority_order])
        rescue Exception=>e
          logger.error "add_email_to_list -> #{e.to_s}"
          err = "#{err}, #{e.to_s}"
        end
      }
    end

    @err = "Updated -> #{@err}"
    render "/admin/home/add_email"
  end



private
    def content_params
      params.require(:node).permit(:title, :title_tag, :body, :meta_keywords, :meta_descriptions, :share_image, :deleted, :is_active, :root_path, :action_path, :layout, :breadcrumb)
    end
end


