class FamilyController < AuthenticatedController
  before_filter :must_be_parent!
  

  # GET /families/
  # GET /families/
  def index
    unless current_user.family
      current_user.family = Family.create
      current_user.save
    end
    
    load_family_members

    @family = current_user.family
    @new_user = User.new(:family => @family)
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def add_member
    @email = params[:user][:email]

    @new_user = User.new(params[:user])

    if params[:user][:parent].to_s == "1"
      @new_user.parent = true
    else
      @new_user.parent = false
    end
    @new_user.family = current_user.family
    @new_user.confirmed_at = Time.now
    
    respond_to do |format|
      if @new_user.save
        return redirect_to family_index_url, :notice => "family member added"
      else
        load_family_members
        format.html { render :action => "new" }
        #          format.json  { render :json => @new_user.errors, :status => :unprocessable_entity }
        #          format.xml   { render :xml => @new_user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def must_be_parent!
    unless current_user && current_user.parent

      return redirect_to minutes_path
    end

  end

  def load_family_members
    @family_members = current_user.family.members
      
    @family_members.reject! { |m|
      m.id == current_user.id 
    }
  end


end
