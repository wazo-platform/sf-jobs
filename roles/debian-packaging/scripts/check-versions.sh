#!/bin/bash

export LANG=C

cd "$1"

for p in $(ls *.deb); do
    name=$(dpkg-deb -f $p Package)
    vers=$(dpkg-deb -f $p Version)
    rem_vers=$(apt-cache policy $name|sed -n 's/.*Candidate:.* //p')
    if ! dpkg --compare-versions "$vers" gt "$rem_vers"; then
        echo "$p not greater than repository version ($rem_vers)"
        exit 1
    fi
done

exit 0

# check-versions.sh ends here
