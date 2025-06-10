#!/usr/bin/bash

# Get the current status of pwm1_enable
PWM1_ENABLE_STATUS=$(cat /sys/devices/platform/hp-wmi/hwmon/hwmon*/pwm1_enable)

# Check the current status and toggle it
if [[ $PWM1_ENABLE_STATUS -eq "2" ]]; then
    echo "Enabling fan boost..."
    echo "0" | sudo tee /sys/devices/platform/hp-wmi/hwmon/hwmon*/pwm1_enable >/dev/null
    echo "Fan boost has been enabled."
else
    echo "Disabling fan boost..."
    echo "2" | sudo tee /sys/devices/platform/hp-wmi/hwmon/hwmon*/pwm1_enable >/dev/null
    echo "Fan boost has been disabled."
fi
