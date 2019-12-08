class StaticPagesController < ApplicationController
  
  def home
    
  end

  def homePageMessage
    respond_to do |format|
    format.html {}
    # The action 'vote' is called here.
    format.js { render :js => "display();" }
    end
    #javascript = File.read(Rails.root.join("app/assets/javascripts/static_pages.js"))
    #context = ExecJS.compile(javascript)
   # context.call("display", "")
    
    redirect_to :action=> :home
  end
  
  def adventures
  end

  def gallery
  end

  def about
  end
end
