cask "pulsebar" do
  version "0.2.0"
  sha256 "397b23f99bd4398907633f49985dd67f920b93c3b26cf598f50a9b88c022cd8d"

  url "https://github.com/skyvis-my/pulsebar/releases/download/v#{version}/Pulsebar-#{version}.zip"
  name "Pulsebar"
  desc "Fixed-width menu bar monitor for bandwidth and ping"
  homepage "https://github.com/skyvis-my/pulsebar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Pulsebar.app"

  # Pulsebar is ad-hoc signed, not notarized, so clear the download quarantine flag.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Pulsebar.app"]
  end

  uninstall quit:       "com.skyvis.pulsebar",
            login_item: "Pulsebar"

  zap trash: [
    "~/Library/Application Support/Pulsebar",
    "~/Library/Preferences/com.skyvis.pulsebar.plist",
  ]
end
