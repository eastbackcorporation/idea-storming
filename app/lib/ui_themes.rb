# frozen_string_literal: true

module UiThemes
  def self.theme(name)
    themes.select do |theme|
      theme.name == name
    end.first
  end

  def self.themes
    dirs = Dir.glob(Rails.public_path.join('themes/*'))
    dirs.map do |dir|
      UiTheme.new(dir)
    end
  end

  class UiTheme
    attr_reader :path, :name, :dir

    def initialize(path)
      @path = path
      @dir = File.basename path
      @name = @dir
      @stylesheets = nil
      @javascripts = nil
    end

    def stylesheet_path(source)
      ext = '.css'
      if File.exist? Rails.public_path.join 'themes', dir, 'stylesheets', source + ext
        Pathname.new('/themes').join(dir, 'stylesheets', source + ext)
      end
    end

    def javascript_path(source)
      ext = '.js'
      if File.exist? Rails.public_path.join 'themes', dir, 'javascripts', source + ext
        Pathname.new('/themes').join(dir, 'javascripts', source + ext)
      end
    end

    def image_path(source)
      if File.exist? Rails.public_path.join 'themes', dir, 'images', source
        Pathname.new('/themes').join(dir, 'images', source)
      end
    end

    module Helper
      def current_ui_theme
        UiThemes.theme(Setting['ui_theme'])
      end
    end
  end
end
