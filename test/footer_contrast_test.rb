# frozen_string_literal: true

require "minitest/autorun"

class FooterContrastTest < Minitest::Test
  def test_footer_background_does_not_follow_theme_text_color
    css = File.read(File.expand_path("../assets/site.css", __dir__))
    footer = css[/\.site-footer\s*\{(?<rules>.*?)\}/m, :rules]

    refute_nil footer
    refute_match(/background:\s*var\(--ink\)/, footer,
                 "footer background becomes light with the dark-mode --ink value")
  end

  def test_installation_is_the_first_getting_started_step
    index = File.read(File.expand_path("../index.html", __dir__))
    layout = File.read(File.expand_path("../_layouts/default.html", __dir__))
    installation = File.expand_path("../guide/installation.md", __dir__)

    assert_match(%r{class="button primary" href="https://pfblockerng.github.io/pkg">Start with installation</a>}, index)
    assert_operator layout.index("/guide/installation/"), :<, layout.index("/guide/general-setup/")
    assert_includes File.read(installation), "https://pfblockerng.github.io/pkg"
  end

  def test_project_documentation_is_canonical
    files = Dir[File.expand_path("../{_layouts,guide}/*", __dir__)]
    content = files.select { |path| File.file?(path) }.map { |path| File.read(path) }.join

    refute_match(%r{docs\.netgate\.com/pfsense/en/latest/packages/pfblocker}, content)
  end
end
