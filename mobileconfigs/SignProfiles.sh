#!/bin/bash

for profile in Profiles/*.mobileconfig
do
	s=${profile##*/}
	outName=${s%.*}
	outName+="Signed.mobileconfig"
	/usr/bin/security cms -S -N "Mac Developer Application" -i $profile -o "$outName"
done