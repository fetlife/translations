#!/bin/sh

git config --global user.email "dev@fetlife.com"
git config --global user.name "FetBot"

CHANGED_LOCALES=`git log -m -1 --name-only --pretty="format:" "$CIRCLE_SHA1" | grep locales`

if [ -z "$CHANGED_LOCALES" ]; then
  echo "No locale files has been changed. No need to deploy anything!"
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

# deploy to vinyl
cd $TMP_DIR
git clone --recursive git@github.com:fetlife/vinyl.git
cd vinyl
git submodule foreach git pull origin master
git add translations
git commit -m "chore(localization): Autoupdate translations"
git push origin HEAD
