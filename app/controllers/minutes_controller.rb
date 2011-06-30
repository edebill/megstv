class MinutesController < AuthenticatedController
  before_filter :load_children

  # GET /minutes
  # GET /minutes.xml
  def index
    unless current_user.family
      return redirect_to :controller => "family", :action => "index"
    end

    respond_to do |format|
      format.html { render "parent" }
      format.xml  { render :xml => @minutes }
    end
  end

  # GET /minutes/1
  # GET /minutes/1.xml
  def show
    @minute = Minute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @minute }
    end
  end

  # GET /minutes/1/edit
  def edit
    @minute = Minute.find(params[:id])
  end

  # POST /minutes
  # POST /minutes.xml
  def create
    @child = nil
    if current_user.parent
      @child = current_user.family.children.select { |c| c.id == params[:minute][:child_id].try(:to_i) }.first
    else
      @child = current_user
      if params[:minute][:amount].to_i > 0
        params[:minute][:amount] = params[:minute][:amount].to_i * -1
      end
    end
    
    return head :status => :not_found unless @child

    @minute = Minute.new(params[:minute].merge( :user_id => current_user.id,
                                                :child_id => @child.id,
                                                :child => @child ))

    respond_to do |format|
      if @minute.save
        format.html { redirect_to minutes_url, :notice => 'Time successfully saved!.' }
        format.xml  { render :xml => @minute, :status => :created, :location => @minute }
      else
        Rails.logger.info("failed to save Minute - #{@minute.errors.full_messages}")
        @minutes = Minute.all
        format.html { redirect_to minutes_url,  :alert => @minute.errors.full_messages }
        format.xml  { render :xml => @minute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /minutes/1
  # PUT /minutes/1.xml
  def update

    @minute = Minute.find(params[:id])

    unless @minute && current_user.can_edit?(@minute)
      return redirect_to minutes_url, :alert => "You don't have permission to edit that."
    end

    respond_to do |format|
      if @minute.update_attributes(params[:minute])
        format.html { redirect_to minutes_url, :notice => 'Minute was successfully updated.' }
        format.xml  { head :ok }
      else
        @minutes = Minute.all
        format.html { render :template => "minutes/parent" }
        format.xml  { render :xml => @minute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /minutes/1
  # DELETE /minutes/1.xml
  def destroy
    @minute = Minute.find(params[:id])
    @minute.destroy

    respond_to do |format|
      format.html { redirect_to(minutes_url) }
      format.xml  { head :ok }
    end
  end

  def load_children
    if current_user.parent
      @children = current_user.family.try(:children)
      @children ||= []
    else
      @children = [ current_user ]
    end
  end


end
