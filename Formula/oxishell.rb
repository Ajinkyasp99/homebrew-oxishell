# Homebrew formula template. The release workflow fills in 0.3.0 and
# ced729d89a2cce3635cc8e757d5d4921fb3f351df55be10727a469bd2626a44a and pushes the result to the tap repository
# (Ajinkyasp99/homebrew-oxishell, as Formula/oxishell.rb).
# Install: brew install Ajinkyasp99/oxishell/oxishell
class Oxishell < Formula
  desc "Terminal workspace manager for AI coding agents"
  homepage "https://github.com/Ajinkyasp99/oxishell"
  url "https://github.com/Ajinkyasp99/oxishell/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "ced729d89a2cce3635cc8e757d5d4921fb3f351df55be10727a469bd2626a44a"
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
      A double-clickable app is attached to each GitHub release as a .dmg.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/oxi --version")
  end
end
