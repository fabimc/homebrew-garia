cask "garia" do
  version "0.1.0"
  sha256 :no_check

  url "https://github.com/fabimc/garia/releases/download/v#{version}/Garia_#{version}_universal.dmg"
  name "Garia"
  desc "Download manager for macOS"
  homepage "https://github.com/fabimc/garia"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :big_sur"

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
end
