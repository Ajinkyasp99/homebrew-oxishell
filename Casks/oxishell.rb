# Homebrew cask template: installs the released Oxishell.app into /Applications
# (the formula only builds the command-line binaries, which macOS does not list
# as an app). The release workflow fills in 0.5.0, 009d8435bf71069447a1022fa6860f1bc2d13755b007ca9d4f6e240e7c063fe0 and
# 1aac7467dc7401b387ec7fa5e6288d7b8caf41f1c8963bf460b898f2c802e044 and pushes the result to the tap repository
# (Ajinkyasp99/homebrew-oxishell, as Casks/oxishell.rb).
# Install: brew install Ajinkyasp99/oxishell/oxishell   (or with --cask)
# There is deliberately no formula named oxishell in the tap (the CLI-only one
# is oxishell-cli), so the plain command installs this cask and the app.
cask "oxishell" do
  arch arm: "arm64", intel: "x86_64"

  version "0.5.0"
  sha256 arm:   "009d8435bf71069447a1022fa6860f1bc2d13755b007ca9d4f6e240e7c063fe0",
         intel: "1aac7467dc7401b387ec7fa5e6288d7b8caf41f1c8963bf460b898f2c802e044"

  url "https://github.com/Ajinkyasp99/oxishell/releases/download/v#{version}/oxishell_#{version}_macos_#{arch}.dmg"
  name "Oxishell"
  desc "Terminal workspace manager for AI coding agents"
  homepage "https://github.com/Ajinkyasp99/oxishell"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Built on macOS 15 against Homebrew libraries that target it (LSMinimumSystemVersion).
  depends_on macos: ">= :sequoia"

  app "Oxishell.app"
  binary "#{appdir}/Oxishell.app/Contents/MacOS/oxi"

  zap trash: [
    "~/.config/oxishell",
    "~/.local/state/oxishell",
    "~/Library/Saved Application State/dev.oxishell.Oxishell.savedState",
  ]

  caveats <<~EOS
    Oxishell is signed ad hoc, not notarized by Apple. If macOS refuses to open it
    the first time, allow it in System Settings > Privacy & Security ("Open Anyway"),
    or run:
      xattr -dr com.apple.quarantine #{appdir}/Oxishell.app

    The `oxi` CLI is linked into Homebrew's bin. If the command-line formula is
    installed, remove it first: brew uninstall --formula oxishell-cli
    (or, from oxishell 0.3.0: brew uninstall --formula oxishell)
  EOS
end
