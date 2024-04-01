#!/usr/bin/env dash
req=$(curl -s 'wttr.in/06483?format=UV:%u+%c🌬%w')
bar=$(echo $req | awk -F "|" '{print $1}')
tooltip=$(echo $req | awk -F "|" '{print $2}')
echo "{\"text\":\"$bar\", \"tooltip\":\"$tooltip\"}"
