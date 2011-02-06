class MinutesController < ApplicationController
  # GET /minutes
  # GET /minutes.xml
  def index
    @minutes = Minute.all

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
        format.html { redirect_to(@minute, :notice => 'Minute was successfully created.') }
        format.xml  { render :xml => @minute, :status => :created, :location => @minute }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @minute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /minutes/1
  # PUT /minutes/1.xml
  def update
    @minute = Minute.find(params[:id])

    respond_to do |format|
      if @minute.update_attributes(params[:minute])
        format.html { redirect_to(@minute, :notice => 'Minute was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
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
