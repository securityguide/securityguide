
module Jekyll

  class NavigationMenuTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      @li_class, @a_class, @active_class = text.split(' ')
      super
    end

    def render(context)
      render_menu(context)
    end

    private

    def render_menu(context)
      @page = context.registers[:page]
      @site = context.registers[:site]
      @menu_data = @site.data["menu"]
      @site.data["pages_by_path"] ||= Hash[
        @site.pages.map {|page| [page.path, page]}
      ]
      render_menu_items(@menu_data)
    end

    def render_menu_items(items, options={})
      options[:level] ||= 0
      items.map.each { |menu_item|
        render_menu_item(menu_item, options)
      }.join("\n")
    end

    def render_menu_item(menu_item, options={})
      if options[:prefix].nil? || options[:prefix] == ""
        prefix = ""
      else
        prefix = options[:prefix] + "/"
      end
      level   = options[:level]
      subtree = ""
      if menu_item.is_a? String
        if menu_item =~ /\((.*?)\)/
          page = find_page($1)
        else
          page = find_page(prefix + menu_item)
        end
        return render_error(menu_item, level) unless page
      elsif menu_item.is_a? Hash
        index   = menu_item.keys.first
        path    = prefix + index
        page    = find_page(path)
        return render_error(index, level) unless page
        if @page['path'] =~ /\A#{Regexp.escape(path)}\//
          subtree = render_menu_items(
            menu_item.values.first,
            prefix: prefix + index,
            level: level + 1
          )
        end
      end
      title    = page["nav_title"] || page["title"] || page.name
      selected = page.url == @page["url"]
      render_item(level: level, selected: selected, url: page.url, title: title) + subtree
    end

    def render_item(level:, selected:, url:, title:)
%(<li class="nav-level-#{level} #{@li_class}">
  <a class="nav-level-#{level} #{@a_class} #{@active_class if selected}" href="#{url}">#{title}</a>
</li>)
    end

    def render_error(page_name, level)
      puts "ERROR: no page with name '#{page_name}'"
%(<li class="nav-level-#{level} #{@li_class}">
  <a class="nav-level-#{level} #{@a_class}" href="#">No Page #{page_name}</a>
</li>)
    end

    def find_page(name)
      if @site.data["pages_by_path"]
        @site.data["pages_by_path"][name + ".md"] ||
        @site.data["pages_by_path"][name + "/index.md"]
      else
        @site.pages.find {|page|
          page.path == name + ".md" || page.path == name + "/index.md"
        }
      end
    end

  end
end

Liquid::Template.register_tag('navigation_menu', Jekyll::NavigationMenuTag)

