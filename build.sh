#!/bin/bash

die() {
    echo "Error!"
    waitkey
    exit 1
}

waitkey() {
    read -n 1 -s -r -p "Press any key to continue"
}

echo "Copying 'src' to 'chrome'..."
mkdir -p ./build/chrome
rsync -r -m --delete ./src/ ./build/chrome/ || die

echo "Zipping the Chrome build..."
cd ./build/chrome || die
rm -f manifest_firefox.json
zip -9 -q -r ImagusReborn_Chrome_v`sed -n -E 's/^.*"version":\s*"(\S*)".*/\1/p' manifest.json`.zip *

cd ../..
echo "Copying 'src' to 'firefox'..."
mkdir -p ./build/firefox
rsync -r -m --delete ./src/ ./build/firefox/ || die

echo "Zipping the Firefox build..."
cd ./build/firefox || die
mv -f manifest_firefox.json manifest.json
zip -9 -q -r ImagusReborn_Firefox_v`sed -n -E 's/^.*"version":\s*"(\S*)".*/\1/p' manifest.json`.zip *

echo "Done!"
waitkey
