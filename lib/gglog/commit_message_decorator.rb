#coding: utf-8
require 'rainbow'

module Gglog
  module CommitMessageDecorator
    def display
      first_line_display_width = 70
      if string_display_width(first_line) < first_line_display_width
        body = sprintf("%-#{first_line_display_width}s", first_line)
      else
        body = first_line[0..(first_line_display_width-5)]+" ..."
      end
      prefix = sprintf("%50s", "#{File.basename(repository)} #{sha}".color("333333"))
      "  #{body} #{prefix}"
    end

    def string_display_width(string)
      string.each_char.map{|char| char_display_width(char) }.inject(0, &:+)
    end

    def char_display_width(char)
      char.bytesize == 1 ? 1 : 2
    end
  end
end
