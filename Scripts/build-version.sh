#!/bin/bash

# This script automatically sets the version and short version string of
# an Xcode project from the Git repository containing the project.
#
# To use this script in Xcode, add the script's path to a "Run Script" build
# phase for your application target.

set -o errexit
set -o nounset

# First, check for git in $PATH
hash git 2>/dev/null || { echo >&2 "Git required, not installed.  Aborting build number update script."; exit 0; }

# Alternatively, we could use Xcode's copy of the Git binary,
# but old Xcodes don't have this.
#GIT=$(xcrun -find git)

# Run Script build phases that operate on product files of the target that defines them should use the value of this build setting [TARGET_BUILD_DIR]. But Run Script build phases that operate on product files of other targets should use “BUILT_PRODUCTS_DIR” instead.
INFO_PLIST="${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
INFO_STRINGS="${TARGET_BUILD_DIR}/${INFOSTRINGS_PATH}"

# Build version (closest-tag-or-branch "-" commits-since-tag "-" short-hash dirty-flag)
BUILD_VERSION=$(git describe --tags --always --dirty=+)

# Use the latest tag for short version (expected tag format "n[.n[.n]]")
LATEST_TAG=$(git describe --tags --abbrev=0)
COMMIT_COUNT_SINCE_TAG=$(git rev-list --count ${LATEST_TAG}..)
if [ $LATEST_TAG = "start" ]
  then LATEST_TAG=0
fi
if [ $COMMIT_COUNT_SINCE_TAG = 0 ]; then
  SHORT_VERSION="$LATEST_TAG"
else
  # increment final digit of tag and append "d" + commit-count-since-tag
  # e.g. commit after 1.0 is 1.1d1, commit after 1.0.0 is 1.0.1d1
  # this is the bit that requires /bin/bash
  OLD_IFS=$IFS
  IFS="."
  VERSION_PARTS=($LATEST_TAG)
  LAST_PART=$((${#VERSION_PARTS[@]}-1))
  VERSION_PARTS[$LAST_PART]=$((${VERSION_PARTS[${LAST_PART}]}+1))
  SHORT_VERSION="${VERSION_PARTS[*]}d${COMMIT_COUNT_SINCE_TAG}"
  IFS=$OLD_IFS
fi

# Bundle version (commits-on-master[-until-branch "." commits-on-branch])
# Assumes that two release branches will not diverge from the same commit on master.
if [ $(git rev-parse --abbrev-ref HEAD) = "master" ]; then
  MASTER_COMMIT_COUNT=$(git rev-list --count HEAD)
  BRANCH_COMMIT_COUNT=0
  BUNDLE_VERSION="$MASTER_COMMIT_COUNT"
else
  MASTER_COMMIT_COUNT=$(git rev-list --count $(git rev-list master.. | tail -n 1)^)
  BRANCH_COMMIT_COUNT=$(git rev-list --count master..)
  if [ $BRANCH_COMMIT_COUNT = 0 ]
    then BUNDLE_VERSION="$MASTER_COMMIT_COUNT"
    else BUNDLE_VERSION="${MASTER_COMMIT_COUNT}.${BRANCH_COMMIT_COUNT}"
  fi
fi

defaults write "$INFO_PLIST" CFBundleBuildVersion "$BUILD_VERSION"
defaults write "$INFO_PLIST" CFBundleShortVersionString "$SHORT_VERSION"
defaults write "$INFO_PLIST" CFBundleVersion "$BUNDLE_VERSION"

# substitute version information into InfoPlist.strings
# this only works for English, and only for the main app :-(
if [[ "$TARGET_NAME" = "ResKnife Cocoa" && "$DEVELOPMENT_LANGUAGE" = "English" ]]; then
  # refresh the index and check if it is dirty
  LANG=C
  LC_CTYPE=C
  BUILD_YEAR=$(date +%Y)
  git update-index -q --refresh
  #DIRTY=$(git diff-index --quiet HEAD; echo $?)
  DIRTY=0; git diff-index --quiet HEAD || DIRTY=1
  BUILD_HASH=$(git rev-parse --short HEAD)
  if [ $DIRTY = 0 ]
    then BUILD_ID="$BUILD_HASH"
    else BUILD_ID="${BUILD_HASH}+"
  fi
  # there is a tool called envsubst that does does this, but I dont have it installed.
  iconv -f utf-16 -t utf-8 < "${PROJECT_DIR}/Cocoa/English.lproj/InfoPlist.strings" | sed -e "s/\$SHORT_VERSION/${SHORT_VERSION}/g" -e "s/\$BUILD_ID/${BUILD_ID}/g" -e "s/\$BUILD_YEAR/${BUILD_YEAR}/g" | iconv -f utf-8 -t utf-16 > "$INFO_STRINGS"
  # these don't work, but are supposed to be more general
  #iconv -f utf-16 -t utf-8 < "${PROJECT_DIR}/Cocoa/English.lproj/InfoPlist.strings" | sed -e "s/\$(\w+)/$ENV{$1}/" | iconv -f utf-8 -t utf-16 > "$INFO_STRINGS"
  #iconv -f utf-16 -t utf-8 < "${PROJECT_DIR}/Cocoa/English.lproj/InfoPlist.strings" | perl -p -e 's/\$\{(\w+)\}/$ENV{$1}/eg' | iconv -f utf-8 -t utf-16 > "$INFO_STRINGS"
fi

# For debugging:
#echo "BUILD VERSION: $BUILD_VERSION"
#echo "LATEST_TAG: $LATEST_TAG"
#echo "COMMIT_COUNT_SINCE_TAG: $COMMIT_COUNT_SINCE_TAG"
#echo "SHORT VERSION: $SHORT_VERSION"
#echo "MASTER_COMMIT_COUNT: $MASTER_COMMIT_COUNT"
#echo "BRANCH_COMMIT_COUNT: $BRANCH_COMMIT_COUNT"
#echo "BUNDLE_VERSION: $BUNDLE_VERSION"
#echo "INFOSTRINGS_PATH: $INFOSTRINGS_PATH"
#echo "INFO_STRINGS: $INFO_STRINGS"
