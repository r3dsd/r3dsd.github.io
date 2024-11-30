module Jekyll
  class LyricsBlock < Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
      @options = parse_options(markup)
    end

    def render(context)
      content = super.strip

      default_color_classes = {
        "original" => "lyric-original-color",
        "pronunciation" => "lyric-pronunciation-color",
        "translate" => "lyric-translate-color"
      }

      classes = default_color_classes.merge(@options)

      lines = content.split("\n").map.with_index do |line, index|
        line_name = case index % 3
                    when 0 then "original"
                    when 1 then "pronunciation"
                    when 2 then "translate"
                    end
        color_class = classes[line_name]
        "<span class='lyric-line-#{line_name} #{color_class}'>#{line}</span>"
      end

      "<div class='lyrics-box'>
        <h2 class='lyrics-title'>가사</h2>
        #{lines.join}
      </div>"
    end

    private

    def parse_options(markup)
      options = {}
      markup.scan(/(\w+):\s*([\w-]+)/).each do |key, value|
        options[key] = value
      end
      options
    end
  end
end

Liquid::Template.register_tag("lyrics", Jekyll::LyricsBlock)
