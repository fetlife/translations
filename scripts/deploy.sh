#!/bin/sh

git config --global user.email "dev@fetlife.com"
git config --global user.name "FetBot"

mkdir -p tmp
cd tmp
git clone --recursive git@github.com:fetlife/fetlife-web.git
cd fetlife-web
git submodule foreach git pull origin master
git add config/locales/translations
git commit -m "Autoupdate translations"
git push origin HEAD
