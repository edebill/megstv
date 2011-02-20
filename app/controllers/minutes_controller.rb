class MinutesController < AuthenticatedController
  # GET /minutes
  # GET /minutes.xml
  def index
    unless current_user.family
      return redirect_to :controller => "family", :action => "index"
    end


    @minutes = Minute.all
    @minute = Minute.new(:child_id => current_user.family.children.first.try(:id),
                         :user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
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

  # GET /minutes/new
  # GET /minutes/new.xml
  def new
    @minute = Minute.new

    respond_to do |format|
      format.html # new.html.erb
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
    @minute = Minute.new(params[:minute])

    respond_to do |format|
      if @minute.save
        format.html { redirect_to minutes_url, :notice => 'Minute was successfully created.' }
        format.xml  { render :xml => @minute, :status => :created, :location => @minute }
      else
        @minutes = Minute.all
        format.html { render :action => "index" }
        format.xml  { render :xml => @minute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /minutes/1
  # PUT /minutes/1.xml
  def update
    @minute = Minute.find_by_id_and_user_id(params[:id], current_user.id)

#    @minute || return head :not_found

    respond_to do |format|
      if @minute.update_attributes(params[:minute])
        format.html { redirect_to minutes_url, :notice => 'Minute was successfully updated.' }
        format.xml  { head :ok }
      else
        @minutes = Minute.all
        format.html { render :action => "index" }
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
end