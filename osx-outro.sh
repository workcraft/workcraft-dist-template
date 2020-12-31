# Update Info.plist with version tag (OSX sed in-place edit requires backup extension)
info_plist="$platform_path/$workcraft/Contents/Info.plist"
sed -i.bak "s/__VERSION__/${tag}/" $info_plist
rm -f ${info_plist}.bak
