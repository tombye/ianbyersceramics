#!/bin/bash

usage() {
  cat << EOF
  Usage: $0 [options]
  Deploy a new version to the remote host

  OPTIONS:
    -s just deploy static assets
    -w just deploy webapp
EOF
}

JUST_STATIC_ASSETS=0
JUST_WEBAPP=0

while getopts "hsw" OPTION; do
  case $OPTION in
    h )
      usage
      exit 1
      ;;
    s )
      JUST_STATIC_ASSETS=1
      ;;
    w )
      JUST_WEBAPP=1
      ;;
  esac
done
shift $(($OPTIND-1))

echo "Building static site."
# 2. build project
npm install
npm run build
bundle exec rake
bundle exec jekyll build

if [ $JUST_WEBAPP -eq 0 ]; then
  echo "Copy static asset files to remote host"
  # 3. rsync static assets to public folder on remote host
  rsync -avzP  _site/public/ tombyers.co.uk:ianbyersceramics.co.uk/public
fi

if [ $JUST_STATIC_ASSETS -eq 0 ]; then
  echo "Copy webapp files to remote host"
  # 3. rsync latest version of webapp to relevant folder on remote host
  rsync -avzP --exclude _site/public _site/ tombyers.co.uk:ianbyersceramics.co.uk
fi
