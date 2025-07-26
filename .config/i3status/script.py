#!/usr/bin/env python3

import datetime
import psutil
import subprocess

clock = ""

battery_icons = {
    "full": "",
    "3_4": "",
    "half": "",
    "1_4": "",
    "empty": "",
    "plug": ""
}

volume_icons = {
    "high": "",
    "low": "",
    "off": ""
}

def has_battery() -> bool:
    battery = psutil.sensors_battery()
    return battery is not None

# ---

def get_battery() -> str:
    battery = psutil.sensors_battery()
    
    if battery is None:
        return "No battery"

    percent = battery.percent
    plugged = battery.power_plugged

    # Choose icon based on battery level
    if percent >= 90:
        icon = battery_icons["full"]
    elif percent >= 60:
        icon = battery_icons["3_4"]
    elif percent >= 40:
        icon = battery_icons["half"]
    elif percent >= 20:
        icon = battery_icons["1_4"]
    else:
        icon = battery_icons["empty"]

    # Add plug icon if charging
    if plugged:
        icon += battery_icons["plug"]

    status = "Charging" if plugged else "Discharging"
    return f"{icon} {percent:.0f}% {status}"

def get_volume() -> str:
    try:
        percent_str = subprocess.check_output(["pamixer", "--get-volume-human"], text=True).strip()
        percent_int = int(percent_str.replace("%", ""))

        if percent_int == 0:
            icon = volume_icons["off"]
        elif percent_int <= 30:
            icon = volume_icons["low"]
        else:
            icon = volume_icons["high"]

        return f"{icon}  {percent_str}"
    except Exception:
        return "Volume error"

def get_date() -> str:
    time = datetime.datetime.now()
    return f"{clock}  {time.day:02d}/{time.month:02d}/{time.year:02d} {time.hour:02d}:{time.minute:02d}:{time.second:02d}"

def main() -> None:
    strings = []

    if has_battery():
        strings.append(get_battery())

    strings.append(get_volume())
    strings.append(get_date())

    res = " | ".join(strings) + " |"
    print(res)

if __name__ == "__main__":
    while True:
        main()
