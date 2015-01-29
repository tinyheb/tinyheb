#!/bin/bash

# write lynx command file
echo "key Up Arrow" > $1.lynx
echo "key ^J" >> $1.lynx
echo "key <delete>" >> $1.lynx
echo "key <delete>" >> $1.lynx
echo "key <delete>" >> $1.lynx
echo "key <delete>" >> $1.lynx
echo "key <delete>" >> $1.lynx
echo "key <delete>" >> $1.lynx
echo "key <delete>" >> $1.lynx
echo "key <delete>" >> $1.lynx
echo "key <delete>" >> $1.lynx
echo "key <delete>" >> $1.lynx
echo "key ${3:0:1}" >> $1.lynx
echo "key ${3:1:1}" >> $1.lynx
echo "key ." >> $1.lynx
echo "key ${3:3:1}" >> $1.lynx
echo "key ${3:4:1}" >> $1.lynx
echo "key ." >> $1.lynx
echo "key ${3:6:1}" >> $1.lynx
echo "key ${3:7:1}" >> $1.lynx
echo "key ${3:8:1}" >> $1.lynx
echo "key ${3:9:1}" >> $1.lynx
echo "key Down Arrow" >> $1.lynx
echo "key ^J" >> $1.lynx
echo "key /" >> $1.lynx
echo "key ${2:0:1}" >> $1.lynx
echo "key ${2:1:1}" >> $1.lynx
echo "key ${2:2:1}" >> $1.lynx
echo "key ${2:3:1}" >> $1.lynx
echo "key ^J" >> $1.lynx
echo "key ^J" >> $1.lynx
echo "key Up Arrow" >> $1.lynx
echo "key Up Arrow" >> $1.lynx
echo "key Up Arrow" >> $1.lynx
echo "key Up Arrow" >> $1.lynx
echo "key Up Arrow" >> $1.lynx
echo "key ^J" >> $1.lynx
echo "key Up Arrow" >> $1.lynx
echo "key q" >> $1.lynx
echo "key j" >> $1.lynx

# write control input
echo "PREIS" > $1.in
echo "$4" >> $1.in

