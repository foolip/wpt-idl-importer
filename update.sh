#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

git clone --single-branch https://github.com/tidoust/reffy-reports.git

cd reffy-reports
reffy_sha=`git rev-parse --short HEAD`
# Apply fixes by merging in the wpt-idl-fixups branch.
# Used if the reffy-reports output is temporarily broken.
# git pull https://github.com/foolip/reffy-reports.git wpt-idl-fixups
cd ..

git clone --single-branch https://github.com/web-platform-tests/wpt.git

cp reffy-reports/whatwg/idl/*.idl wpt/interfaces/

cd wpt

git remote add fork https://autofoolip:$GH_TOKEN@github.com/autofoolip/wpt.git
git push fork master

# First handle added (untracked, --other) and modified files.
# A temp file is needed because `git ls-files` holds index.lock.
tmpfile=`mktemp`
git ls-files --modified --others --exclude-standard > "$tmpfile"
cat "$tmpfile" | while read path; do
    echo "Handling $path"
    shortname=`basename $path .idl`
    branchname="idl-file-updates-$shortname"
    git checkout -b $branchname origin/master
    git add "$path"
    git commit -F - << EOM
Update $path

Copied by https://github.com/foolip/wpt-idl-importer from:
https://github.com/tidoust/reffy-reports/blob/$reffy_sha/whatwg/idl/$shortname.idl
EOM
    git push -f fork $branchname
done
rm "$tmpfile"

# TODO: Check if wpt has IDL files not in reffy-reports and list them.
