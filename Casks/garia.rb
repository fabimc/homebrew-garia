cask "garia" do
  version "0.2.0"
  sha256 "cddf72a4b2e853105f296f2d9ecab5e3fa470a6c565ebe257cad4b0a8dc58559"

  url "https://github.com/fabimc/garia/releases/download/v#{version}/Garia_#{version}_universal.dmg"
  name "Garia"
  desc "Download manager"
  homepage "https://github.com/fabimc/garia"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Garia.app"

  uninstall quit: "com.fabimc.garia"

  zap trash: [
    "~/Library/Application Support/com.fabimc.garia",
    "~/Library/Caches/com.fabimc.garia",
    "~/Library/HTTPStorages/com.fabimc.garia",
    "~/Library/LaunchAgents/com.fabimc.garia.plist",
    "~/Library/Logs/com.fabimc.garia",
    "~/Library/Preferences/com.fabimc.garia.plist",
    "~/Library/Saved Application State/com.fabimc.garia.savedState",
    "~/Library/WebKit/com.fabimc.garia",
  ]

  caveats <<~EOS
    Garia is not notarized. If macOS says it is damaged or cannot be opened, run:
      xattr -dr com.apple.quarantine /Applications/Garia.app
  EOS
end
