#creation Local Administrator
dscl . -create /Users/ldmin
dscl . -create /Users/ladmin UserShell /bin/bash
dscl . -create /Users/ladmin RealName "Local Administrator"
dscl . -create /Users/ladmin UniqueID "1010"
dscl . -create /Users/ladminPrimaryGroupID 80
dscl . -create /Users/ladmin NFSHomeDirectory /Users/ladmin
dscl . -passwd /Users/luser
dscl . -append /Groups/admin GroupMembership ladmin
echo "!!----Local Administrator Created----!!"

#no power saving
pmset -autorestart 1
pmset -a displaysleep 0
echo "!!----power saving disabilited----!!"

#Assign name of Mac
echo "name of mac:"
echo " "
read nomemac
sudo hostname $nomemac
sudo scutil --set ComputerName $nomemac
echo " "
echo "$nomemac is the new name"

#impostazioni IP Subnet Gateway e DNS
echo " write IP _ Subnet _ Gateway "
read networksettings
networksetup -setmanual "Ethernet" $networksettings
echo "!!----static ip address success----!!"
networksetup -setdnsservers "Ethernet"
echo "!!----DNS setted----!!"

#turn off wifi
networksetup -setairportpower Wi-Fi off
echo "!!----wifi turned off----!!"

#----------cache command ----------

sudo -u _assetcache defaults write /Library/Preferences/com.apple.AssetCache.plist PeerLocalSubnetsOnly true

#SetIP pool
sudo -u _assetcache defaults write /Library/Preferences/com.apple.AssetCache.plist PublicRanges '( { first = ; last = ; } )'

#Set parents
sudo -u _assetcache defaults write /Library/Preferences/com.apple.AssetCache.plist Parents '(  )'

#Set sharedcache
sudo defaults write /Library/Preferences/com.apple.AssetCache.plist AllowSharedCaching true
sudo defaults write /Library/Preferences/com.apple.AssetCache.plist AllowPersonalCaching false

#Ricarica la configurazione
sudo AssetCacheManagerUtil reloadSettings


echo "Script loaded succefully"
