#!/bin/sh
df | sed 1d |
while read a;
do
#size=$(echo $a | awk '{print $2/1024}' | bc);

size=$(echo $a | awk '{print $2}');
used=$(echo $a | awk '{print $3}');
available=$(echo $a | awk '{print $4}');
usedPercent=$(echo $a | awk '{print $5}');
mount=$(echo $a | awk '{print $6}');

echo "Ressources|Filesystem|${mount}a:Size=$size"
echo "Ressources|Filesystem|${mount}a:Used=$used"
echo "Ressources|Filesystem|${mount}a:Available=$available"
echo "Ressources|Filesystem|${mount}a:UsedPercent=${usedPercent%?}"

done
