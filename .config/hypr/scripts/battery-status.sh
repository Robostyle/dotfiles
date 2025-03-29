#!/usr/bin/env bash

############ Variables ############
enable_battery=false
battery_charging=false
path_power_supply=/sys/class/power_supply/
battery=${path_power_supply}BAT0

#         crit 10  20  30  40  50  60  70  80  90  100 %
bat_icons=('󰂃' '󰁺' '󰁻' '󰁼' '󰁽' '󰁾' '󰁿' '󰂀' '󰂁' '󰂂' '󰁹')

####### Check availability ########
if [[ -f "$battery/uevent" ]]; then
    enable_battery=true
    if [[ $(cat $battery/status) == "Charging" ]]; then
        battery_charging=true
    fi
fi

############# Output #############
if [[ $enable_battery == true ]]; then
    if [[ $battery_charging == true ]]; then
        echo -n "󰂄 "
    else
        level=$(cat ${battery}/capacity)
        index=$(($level / 10))
        echo -n "${bat_icons[$index]} "
    fi
    echo -n "$level"%
fi

echo ''
