#!/bin/sh

set -e

rack_list="$1"
release="$2"

if [ -z "$rack_list" -o -z "$release" ]; then
	echo "Usage: $0 rack_list_file release_tag"
	exit 1
fi

bpm_fw="openMMC-afc-bpm-3.1-${release}.bin"
timing_fw="openMMC-afc-timing-${release}.bin"

rm -f "$bpm_fw" "$timing_fw" SHA1SUMS

wget https://github.com/lnls-dig/openMMC/releases/download/${release}/${bpm_fw}
wget https://github.com/lnls-dig/openMMC/releases/download/${release}/${timing_fw}
wget https://github.com/lnls-dig/openMMC/releases/download/${release}/SHA1SUMS

sha1sum --ignore-missing -c SHA1SUMS

./mmc-update.sh "$rack_list" ${bpm_fw} ${timing_fw}
