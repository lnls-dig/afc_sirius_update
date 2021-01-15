#!/bin/sh

rack_list=$1
bpm_firmware=$2
timing_firmware=$3

if [ -z "$rack_list" -o -z "$bpm_firmware" -o -z "$timing_firmware" ]; then
	echo "Usage: $0 rack_list_file bpm_firmware_file timing_firmware_file"
	exit 1
fi

if [ ! -f "$rack_list" ]; then
	echo "File '${rack_list}' does not exists"
	exit 1
fi

if [ ! -f "$bpm_firmware" ]; then
	echo "File '${bpm_firmware}' does not exists"
	exit 1
fi

if [ ! -f "$timing_firmware" ]; then
	echo "File '${timing_firmware}' does not exists"
	exit 1
fi

while read line; do
	mch_ip=$(echo $line | tr -s ' ' | cut -d ' ' -f 1)
	timing_slots=$(echo $line | tr -s ' ' | cut -d ' ' -f 2)
	bpm_slots=$(echo $line | cut -d ' ' -f 3)
	./hpm-downloader/bin/hpm-downloader --ip ${mch_ip} --slot "${timing_slots}" "${timing_firmware}"
	./hpm-downloader/bin/hpm-downloader --ip ${mch_ip} --slot "${bpm_slots}" "${bpm_firmware}"
done < "$rack_list"
