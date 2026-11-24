# Homebrew formula template for the command-line build. The release workflow
# fills in 0.5.0 and d7ae54f33f7e506b5b4e6237b9e25848e2dfe8ec1af920c8a22cc942b4e422c7 and pushes the result to the tap repository
# (Ajinkyasp99/homebrew-oxishell, as Formula/oxishell-cli.rb).
#
# It is named oxishell-cli, not oxishell, on purpose: with a formula and a cask
# of the same name, `brew install Ajinkyasp99/oxishell/oxishell` picks the
# formula, which cannot put an app in /Applications. Without a formula of that
# name, the plain command installs the cask (oxishell-cask.rb.in), so Oxishell
# shows up in Applications, Launchpad and Spotlight.
# Install: brew install Ajinkyasp99/oxishell/oxishell-cli
class OxishellCli < Formula
  desc "Terminal workspace manager for AI coding agents (command-line build)"
  homepage "https://github.com/Ajinkyasp99/oxishell"
  url "https://github.com/Ajinkyasp99/oxishell/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "d7ae54f33f7e506b5b4e6237b9e25848e2dfe8ec1af920c8a22cc942b4e422c7"
  license "GPL-3.0-or-later"
  head "https://github.com/Ajinkyasp99/oxishell.git", branch: "main"

  depends_on "pkgconf" => :build
  depends_on "rust" => :build
  depends_on "adwaita-icon-theme"
  depends_on "gtk4"
  depends_on "libadwaita"
  depends_on "librsvg"
  depends_on "vte3"

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Start it with `oxishell` (the `oxi` CLI is installed too).
      This formula installs command-line binaries only, so Oxishell does not
      appear in /Applications or Launchpad. For the app, use the cask instead:
        brew uninstall --formula oxishell-cli
        brew install Ajinkyasp99/oxishell/oxishell
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/oxi --version")
  end
end
