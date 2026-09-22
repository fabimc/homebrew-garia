cask "garia" do
  version "0.1.0"
  sha256 "9e6c278a9387649a0371d769e922c54bbcacc25348c2724b05690e669ab27874"

  url "https://github.com/fabimc/garia/releases/download/v#{version}/Garia_#{version}_universal.dmg"
  name "Garia"
  desc "Download manager"
  homepage "https://github.com/fabimc/garia"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Garia.app"

  caveats <<~EOS
    Garia is not notarized. If macOS says it is damaged or cannot be opened, run:
      xattr -dr com.apple.quarantine /Applications/Garia.app
  EOS

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
