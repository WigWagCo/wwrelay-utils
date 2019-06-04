#!/bin/bash

# Copyright (c) 2018, Arm Limited and affiliates.
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

echo "Updating... /etc/init.d/mbed-edge-core"
cp ./mbed-edge-core /etc/init.d/mbed-edge-core
chmod 755 /etc/init.d/mbed-edge-core

echo "Updating... edge-core to 0.7.1"
killall edge-core
rm /wigwag/mbed/edge-core/build/bin/edge-core
cp ./edge-core /wigwag/mbed/edge-core/build/bin

echo "Updating... logrotate"
cp ./logrotate.conf /etc/logrotate.conf

echo "Updating... led.sh"
cp ./led.sh /wigwag/system/bin/led

echo "Burning new firmware to AT841 micro..."
/etc/init.d/deviceOS-watchdog humanhalt
dogProgrammer ./AT841WDOG_v1.2.hex
/etc/init.d/deviceOS-watchdog start

echo "Update writeEEPROM.js"
cp ./writeEEPROM.js /wigwag/wwrelay-utils/I2C/

echo "Adding check_edge_connection.sh"
cp ./check_edge_connection.sh /wigwag/wwrelay-utils/debug_scripts/
chmod 755 /wigwag/wwrelay-utils/debug_scripts/check_edge_connection.sh

echo "Adding run_mbed_edge_core.sh"
cp ./run_mbed_edge_core.sh /wigwag/wwrelay-utils/debug_scripts/
chmod 755 /wigwag/wwrelay-utils/debug_scripts/run_mbed_edge_core.sh

echo "Update create-new-eeprom with self-signed certs"
cp ./create-new-eeprom-with-self-signed-certs.sh /wigwag/wwrelay-utils/debug_scripts/
chmod 755 /wigwag/wwrelay-utils/debug_scripts/create-new-eeprom-with-self-signed-certs.sh

echo "Updating wwrelay init.d"
cp ./wwrelay /etc/init.d/wwrelay
chmod 755 /etc/init.d/wwrelay

echo "Updating get-eeprom scritps"
cp ./fetch* /wigwag/wwrelay-utils/debug_scripts/tools/
chmod 755 /wigwag/wwrelay-utils/debug_scripts/tools/fetcheeprom.sh
cp ./findedge-gw-dispatcher.js /wigwag/wwrelay-utils/debug_scripts/tools/
cp -R ./node_modules /wigwag/wwrelay-utils/debug_scripts/tools/

echo "Updating factory reset script"
cp ./factory_wipe_gateway.sh /wigwag/wwrelay-utils/debug_scripts/
chmod 755 /wigwag/wwrelay-utils/debug_scripts/factory_wipe_gateway.sh

echo "Update genearte eeprom node.js"
cp ./generate-new-eeprom.js /wigwag/wwrelay-utils/debug_scripts/generate-new-eeprom.js

echo "Updating LEDController/controller.js"
cp ./controller.js /wigwag/wigwag-core-modules/LEDController/

echo "Updating RelayStats"
cp ./relayStatsProvider.js /wigwag/wigwag-core-modules/RelayStatsSender/relayStatsProvider.js

echo "Update playtone script"
cp ./playtone.sh /wigwag/system/bin/playtone
ln -s /wigwag/system/bin/playtone /usr/bin/playtone
chmod 755 /wigwag/system/bin/playtone

echo "Copy play tones..."
cp ./rp200_tones.txt /wigwag/wwrelay-utils/conf/