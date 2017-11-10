#
# Adds the liquid tag "navigation_menu"
#
# Author: elijah@riseup.net
# Copyright (c) 2017 ThoughtWorks
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

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
      href = [@site.baseurl, url].join('/').gsub(/\/+/,'/')
%(<li class="nav-level-#{level} #{@li_class}">
  <a class="nav-level-#{level} #{@a_class} #{@active_class if selected}" href="#{href}">#{title}</a>
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

