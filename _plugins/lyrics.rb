module Jekyll
  class LyricsBlock < Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
      @options = parse_options(markup)
    end

    def render(context)
      content = super.strip

      # 매개변수로 받은 클래스 이름만 처리
      default_classes = {
        "original" => "lyric-original",
        "pronunciation" => "lyric-pronunciation",
        "translate" => "lyric-translate"
      }

      classes = default_classes.merge(@options)

      # <br> 제거, <span> 태그만 생성
      lines = content.split("\n").map.with_index do |line, index|
        css_class = case index % 3
                    when 0 then classes["original"]
                    when 1 then classes["pronunciation"]
                    when 2 then classes["translate"]
                    end
        "<span class='lyric-line #{css_class}'>#{line}</span>"
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
