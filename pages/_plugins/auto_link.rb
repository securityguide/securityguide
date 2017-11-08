=begin

#
# Adds autolinking to Kramdown parser
#

module Kramdown
  module Parser
    class AutoLink < ::Kramdown::Parser::GFM

      AUTO_LINK_RE = %r{
        (?: ((?:ed2k|ftp|http|https|irc|mailto|news|gopher|nntp|telnet|webcal|xmpp|callto|feed|svn|urn|aim|rsync|tag|ssh|sftp|rtsp|afs|file):)// | www\. )
        [^\s<\u00A0]+
      }ix
      #AUTO_LINK_CRE = [/<[^>]+$/, /^[^>]*>/, /<a\b.*?>/i, /<\/a>/i]
      #AUTO_EMAIL_LOCAL_RE = /[\w.!#\$%&'*\/=?^`{|}~+-]/
      #AUTO_EMAIL_RE = /[\w.!#\$%+-]\.?#{AUTO_EMAIL_LOCAL_RE}*@[\w-]+(?:\.[\w-]+)+/
      BRACKETS = { ']' => '[', ')' => '(', '}' => '{' }
      WORD_PATTERN = '\p{Word}'

      def initialize(source, options)
        super
        @block_parsers.unshift(:auto_link)
      end

      def parse_auto_link
        @src.pos += @src.matched_size

        scheme      = @src[1]
        href        = @src[0]
        punctuation = []

        # don't include trailing punctuation character as part of the URL
        while href.sub!(/[^#{WORD_PATTERN}\/-]$/, '')
          punctuation.push $&
          if opening = BRACKETS[punctuation.last] and href.scan(opening).size > href.scan(punctuation.last).size
            href << punctuation.pop
            break
          end
        end

        link_text   = href.sub(/^#{scheme}\/\//,'').sub(/\/\z/, '')
        href        = 'http://' + href unless scheme
        punctuation = punctuation.reverse.join('')

        @tree.children << Element.new(:auto_link, "", href: href, link_text: link_text, punctuation: punctuation)
      end
      define_parser(:auto_link, AUTO_LINK_RE)
    end
  end
end

module Kramdown
  module Converter
    class Html
      def convert_auto_link(el, indent)
        "<a href=\"#{el.attr[:href]}\">#{el.attr[:link_text]}</a>#{el.attr[:punctuation]}"
      end
    end
  end
end

=end
