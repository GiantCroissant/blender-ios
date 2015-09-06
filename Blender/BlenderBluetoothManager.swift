//
//  BlenderBluetoothManager.swift
//  Blender
//
//  Created by Bryan Lin on 9/7/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BlenderConnectionState {
    func didUpdateState()
}

protocol BlenderBluetoothProtocal {
    func didDiscoveredDevice()
    func didConnectedDevice()
}

class BlenderBluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {

    // Blender
    let BLENDER_CONTROL_SERVICE_ID = CBUUID(string: "00001523-1212-efde-1523-785feabcd123")
    let BLENDER_SETTING_CHARACTERISTIC_ID = CBUUID(string: "00001525-1212-EFDE-1523-785FEABCD123")


    var delegate: BlenderBluetoothProtocal?
    var connectionDelegate: BlenderConnectionState?

    class var sharedLoader : BlenderBluetoothManager {
        struct Static {
            static let instance : BlenderBluetoothManager = BlenderBluetoothManager()
        }
        return Static.instance
    }

    var centralManager: CBCentralManager!
    var blenderSetting: CBCharacteristic!
    var connectedDevice: CBPeripheral!

    var devices = [CBPeripheral]()
    var connected = false {
        didSet {
            connectionDelegate?.didUpdateState()
        }
    }

    func startBlending(time: Int, speed: Int) {
        var bytes = [
            UInt8(0xA5), UInt8(0x5A), UInt8(0x07), UInt8(0x01),
            UInt8((time - 1) % 256), UInt8((time - 1) / 256), // Time
            UInt8(speed % 256), UInt8(speed / 256), // Speed
            UInt8(0x01), UInt8(0xB3)
        ] as [UInt8]

        let data = NSData(bytes: &bytes, length: 10)
        if (connectedDevice != nil) {
            connectedDevice.writeValue(data, forCharacteristic: blenderSetting, type: CBCharacteristicWriteType.WithResponse)
        }
    }

    func peripheral(peripheral: CBPeripheral!, didWriteValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        if error != nil {
            println(error)
        }
    }

    func stopBlending() {
        var bytes = [
            UInt8(0xA5), UInt8(0x5A), UInt8(0x07), UInt8(0x01),
            UInt8(0 % 256), UInt8(0 / 256),
            UInt8(0 % 256), UInt8(0 / 256),
            UInt8(0x00), UInt8(0xB3)
            ] as [UInt8]

        let data = NSData(bytes: &bytes, length: 10)
        if (connectedDevice != nil) {
            connectedDevice.writeValue(data, forCharacteristic: blenderSetting, type: CBCharacteristicWriteType.WithResponse)
        }
    }

    func scanBLEDevices() {
        if centralManager == nil {
            centralManager = CBCentralManager(delegate: self, queue: nil)
        }
    }

    func centralManagerDidUpdateState(central: CBCentralManager!) {
        if central.state == CBCentralManagerState.PoweredOn {
            central.scanForPeripheralsWithServices(nil, options: nil)

        } else {
            println("Bluetooth switched off or not initialized")
        }
    }

    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {

        let deviceName = "ITRI_JUICER_v1.0"
        let nameOfDeviceFound = (advertisementData as NSDictionary).objectForKey(CBAdvertisementDataLocalNameKey) as? String
        if nameOfDeviceFound == deviceName {
            if !contains(devices, peripheral) {
                devices.append(peripheral)
            }
            delegate?.didDiscoveredDevice()
        }
    }

    func stopScanBLEDevices() {
        centralManager.stopScan()
    }

    func connectDevice(device: CBPeripheral) {
        centralManager.connectPeripheral(device, options: nil)
    }

    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        connected = true
        connectedDevice = peripheral

        peripheral.delegate = self
        peripheral.discoverServices(nil)
        delegate?.didConnectedDevice()
    }

    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        if (error != nil) {
            println(error)
        }
        for service in peripheral.services {
            let thisService = service as! CBService
            if thisService.UUID == BLENDER_CONTROL_SERVICE_ID {
                peripheral.discoverCharacteristics(nil, forService: thisService)
            }
        }
    }

    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        for characteristic in service.characteristics {
            let thisCharacteristic = characteristic as! CBCharacteristic
            if thisCharacteristic.UUID == BLENDER_SETTING_CHARACTERISTIC_ID {
                blenderSetting = thisCharacteristic
            }
        }
    }

    func centralManager(central: CBCentralManager!, didDisconnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        connected = false
        connectedDevice = nil
    }
}

