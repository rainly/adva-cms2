class Admin::Blogs::Edit < Minimal::Template
  include do
    def to_html
      h2 :'.title'
      render :partial => 'form'
    end
  end
end