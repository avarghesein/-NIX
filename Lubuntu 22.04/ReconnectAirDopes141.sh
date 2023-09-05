#!/bin/bash

bluetoothctl disconnect <MAC address>
bluetoothctl remove <MAC address>
bluetoothctl scan on &
sleep 10
bluetoothctl pair <MAC address>
bluetoothctl connect <MAC address>
