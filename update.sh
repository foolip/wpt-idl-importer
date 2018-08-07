#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

git clone --depth 1 https://github.com/web-platform-tests/wpt.git
git clone --depth 1 https://github.com/tidoust/reffy-reports.git
rm wpt/interfaces/*.idl
cp reffy-reports/whatwg/idl/*.idl wpt/interfaces/
cd wpt
git status
