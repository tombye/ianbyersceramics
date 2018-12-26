#!/bin/bash

usage() {
  cat << EOF
  Usage: $0 [options]
  Deploy a new version to the remote host

  OPTIONS:
    -i Ignore static assets
EOF
}

IGNORE_STATIC_ASSETS=0

while getopts "hd" OPTION; do
  case $OPTION in
    h )
      usage
      exit 1
      ;;
    i )
      IGNORE_STATIC_ASSETS=1
      ;;
  esac
done
shift $(($OPTIND-1))

# Manual step: bump VERSION.txt
#
VERSION=$( cat VERSION.txt )
echo "Version is $VERSION"

WEBAPPS_DIR=/home/tombaromba/webapps

echo "Building static site."
# 2. build project
bundle exec jekyll build

echo "Copy files to remote host"
# 3. rsync latest to latest folder on remote host
rsync -avz --exclude _site/public _site/ "webfactional:$WEBAPPS_DIR/ianbyersceramics"

if [ $IGNORE_STATIC_ASSETS -eq 0 ]; then
  echo "Copy files to remote host"
  # 3. rsync latest to latest folder on remote host
  rsync -avz  _site/public "webfactional:$WEBAPPS_DIR/ianbyersceramics_public"
fi
