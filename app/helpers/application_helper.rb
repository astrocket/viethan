module ApplicationHelper
  include ThemesHelper
  include VinkTimeAgoHelper

  def page_title
    safe_join [content_for(:page_title) || content_for(:thredded_page_title),
               t('brand.name')].compact, ' - '
  end

  def pageless(total_pages, url=nil, container=nil)
    opts = {
        :totalPages => total_pages,
        :url        => url,
        :loaderImage => image_path("loading.svg")
    }
    container && opts[:container] ||= container
    javascript_tag("document.addEventListener('turbolinks:load', function() { $('#{container}').pageless(#{opts.to_json});});")
  end

end
