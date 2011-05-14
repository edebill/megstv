class ScratchesController < AuthenticatedController
  # GET /scratches
  # GET /scratches.xml
  def index
    @scratches = Scratch.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scratches }
    end
  end

  # GET /scratches/1
  # GET /scratches/1.xml
  def show
    @scratch = Scratch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @scratch }
    end
  end

  # GET /scratches/new
  # GET /scratches/new.xml
  def new
    @scratch = Scratch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @scratch }
    end
  end

  # GET /scratches/1/edit
  def edit
    @scratch = Scratch.find(params[:id])
  end

  # POST /scratches
  # POST /scratches.xml
  def create
    @scratch = Scratch.new(params[:scratch])

    respond_to do |format|
      if @scratch.save
        format.html { redirect_to(@scratch, :notice => 'Scratch was successfully created.') }
        format.xml  { render :xml => @scratch, :status => :created, :location => @scratch }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @scratch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /scratches/1
  # PUT /scratches/1.xml
  def update
    @scratch = Scratch.find(params[:id])

    respond_to do |format|
      if @scratch.update_attributes(params[:scratch])
        format.html { redirect_to(@scratch, :notice => 'Scratch was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @scratch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scratches/1
  # DELETE /scratches/1.xml
  def destroy
    @scratch = Scratch.find(params[:id])
    @scratch.destroy

    respond_to do |format|
      format.html { redirect_to(scratches_url) }
      format.xml  { head :ok }
    end
  end
end
