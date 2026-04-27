#!/bin/sh
if bluetoothctl show | grep -q "Powered: yes"; then
    echo ""  # Bluetooth encendido
else
    echo ""  # Bluetooth apagado
fi
