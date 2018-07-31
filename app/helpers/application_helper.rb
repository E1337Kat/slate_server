module ApplicationHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  # Special class so that we can have pretty code highlighting. :)
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def block_code(code, full_lang_name)
      if full_lang_name
        parts = full_lang_name.split('--')
        rouge_lang_name = (parts) ? parts[0] : "" # just parts[0] here causes null ref exception when no language specified
        super(code, rouge_lang_name).sub("highlight #{rouge_lang_name}") do |match|
          match + " tab-" + full_lang_name
        end
      else
        super(code, full_lang_name)
      end
    end
  end

  # Method that is in charge of actually rendering the markdown as needed.
  def markdown(text)
    options = {
      prettify: true,
      with_toc_data: true
    }

    extensions = {
      tables: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true
    }

    renderer = HTML.new(options) # Use custom Renderer
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  # Should help with active toc, but does not seem to work. :(
  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end
end
