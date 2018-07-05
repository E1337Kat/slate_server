module ApplicationHelper
  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: {rel: 'nofollow', target: '_blank' },
      space_afer_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink: true,
      superscript: true,
      disable_indented_code_blocks: false
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end
end
