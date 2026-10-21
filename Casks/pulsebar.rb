cask "pulsebar" do
  version "0.3.1"
  sha256 "847a27aedded0d321712070a257185ae6fed792f5ab64fb2d40b70fe4991e749"

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
