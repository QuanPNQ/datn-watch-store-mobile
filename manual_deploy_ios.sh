#!/bin/sh
# Author: Greenify VietNam (greenifyvn@gmail.com)

set +x
SHA=$(git rev-parse HEAD)

echo "*** MANUALLY DEPLOY TO APPLE STORE ***"
echo "Commit: ${SHA}"
cd ios
bundle install
bundle exec fastlane ios store_bundle
cd -
echo "*** End ***"
set -x
