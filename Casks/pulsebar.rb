cask "pulsebar" do
  version "0.3.4"
  sha256 "ae1bb35434e2dc4fde7023d6affc30130b8f74b4f101bef0d2eee23042fc5c44"

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
