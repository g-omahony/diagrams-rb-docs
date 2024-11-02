# frozen_string_literal: true

require 'diagrams-rb'
require 'pry'

Jekyll::Hooks.register :site, :after_init do
  # ResourceWriter.clean_icons_dir
  # ResourceWriter.write_md
end

class ResourceWriter # rubocop:disable Style/Documentation
  class << self
    def write_md # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      spec = Gem::Specification.find_by_name('diagrams-rb')
      source = "#{spec.gem_dir}/resources"
      FileUtils.cp_r(source, icons_dir)

      @current_filename = ''.dup
      Dir.glob("#{icons_dir}/**/*.png").sort.each do |file_path|
        parts = file_path.sub("#{icons_dir}/", '').split('/')
        method = File.basename(parts.pop, '.png')
        namespace = parts.map(&:capitalize).join('::')
        write_to_file(
          icons_dir,
          parts.first,
          "|\!\[\]\({{ '#{file_path.gsub('/site', '')}' \| relative_url }}\)#{icon_fmt}" \
          "|`#{namespace}.#{method.gsub('-', '_')}`#{method_fmt}|\n"
        )
      end
    end

    def clean_icons_dir
      FileUtils.rm_r(icons_dir) if Dir.exist?(icons_dir)
    end

    private

    def write_to_file(destination, title, data)
      filename = "#{destination}/#{title}.md"
      if @current_filename != filename
        @file&.close

        @current_filename = filename
        @file = File.open(@current_filename, 'a')
        write_header(@file, title)
      end
      @file.write(data)
    end

    def write_header(file, title)
      file.write("---\n")
      file.write("title: #{title}\n")
      file.write("parent: Sources\n")
      file.write("layout: page\n")
      file.write("nav_enabled: true\n")
      file.write("---\n")
      file.write("\n")
      file.write("| Icon | Source |\n")
      file.write("|-----|-----|\n")
    end

    def icons_dir
      @icons_dir ||= "#{Dir.pwd}/icons"
    end

    def icon_fmt
      '{: width="22" }'
    end

    def method_fmt
      '{: .language-ruby .highlighter-rouge .highlight style="font-size: 14px"}'
    end
  end
end
