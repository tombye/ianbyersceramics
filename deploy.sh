#!/bin/bash

usage() {
  cat << EOF
  Usage: $0 [options]
  Deploy a new version to the remote host

  OPTIONS:
    -d Deploy the code in the 'latest' folder on the remote host
EOF
}

DEPLOY_LATEST=1

while getopts "hd" OPTION; do
  case $OPTION in
    h )
      usage
      exit 1
      ;;
    d )
      DEPLOY_LATEST=0
      ;;
  esac
done
shift $(($OPTIND-1))

# Manual step: bump VERSION.txt
#
VERSION=$( cat VERSION.txt )
echo "Version is $VERSION"

# 1. Check if version has been bumped
if ssh webfactional "[ -d /home/tombaromba/webapp_releases/ianbyersceramics/$VERSION ]"; then
  echo "Version $VERSION already exists."
  VERSION_EXISTS=0
else
  VERSION_EXISTS=1
fi

RELEASES_DIR=/home/tombaromba/webapp_releases/ianbyersceramics
WEBAPPS_DIR=/home/tombaromba/webapps

if [ $VERSION_EXISTS -eq 1 ]; then

  echo "Building static site."
  # 2. build project
  bundle exec jekyll build

  echo "Copy files to remote host"
  # 3. rsync latest to latest folder on remote host
  rsync -avz _site/ "webfactional:$RELEASES_DIR/latest"

  echo "Split out latest public files on remove host and save latest as version on remote host"
  # 4. rsync latest to latest folder on remote host and make new version dir on remote host
  ssh -t webfactional "rsync -avz $RELEASES_DIR/latest/public/ $RELEASES_DIR/latest_public; mkdir $RELEASES_DIR/$VERSION; cp -r $RELEASES_DIR/latest/* $RELEASES_DIR/$VERSION"
fi

if [ $DEPLOY_LATEST -eq 0 ]; then
  echo "rsync web app to latest and rsync web app public to latest public folder"
  ssh -t webfactional "rsync -avz $RELEASES_DIR/latest/ $WEBAPPS_DIR/ianbyersceramics; rsync -avz $RELEASES_DIR/latest_public $WEBAPPS_DIR/ianbyersceramics_public"
fi
