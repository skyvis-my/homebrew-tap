cask "pulsebar" do
  version "0.3.0"
  sha256 "fa357d5dcdf8093c127d1654cc20d458154f4e101153e78c553e59b83777ce54"

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
