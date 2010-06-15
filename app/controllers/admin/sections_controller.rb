class Admin::SectionsController < Admin::BaseController
  helper :sections
  helper_method :site, :section, :sections

  def index
  end
  
  def show
    redirect_to :action => :edit # TODO TMP!
  end

  def new
  end

  def create
    @section = params[:section][:type].constantize.create(params[:section].merge(:site_id => site.id))
    respond_with :admin, site, section, section.article
  end

  def edit
  end

  def update
    section.update_attributes!(params[:section])
    redirect_to edit_admin_site_section_path(site, section)
  end

  def destroy
    section.destroy
    redirect_to :action => :index
  end

  protected

    def resources(action = nil)
      [:admin, site, section].tap { |r| r.unshift(action) if action }
    end

    def site
      @site ||= Site.find(params[:site_id])
    end

    def section
      @section ||= params[:id] ? site.sections.find(params[:id]) : site.sections.build(:type => 'Page')
    end

    def sections
      @sections ||= site.sections
    end
end