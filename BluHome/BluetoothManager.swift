//
//  BluetoothManager.swift
//  BluHome
//
//  Created by mohammad mugish on 03/12/19.
//  Copyright © 2019 mohammad mugish. All rights reserved.
//

import Foundation
import CoreBluetooth
import MMWormhole


class BluetoothManager : NSObject, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    
    let batteryCharUUID = "2a19"
    let fanSpeedCharUUID = "2a19"
    
    var fanSpeedChar : CBCharacteristic?
    var connectedDevicePeripheral : CBPeripheral?
    
    
    var centralManager : CBCentralManager!
    
    
    let SiriFanMemory = MMWormhole(applicationGroupIdentifier: "group.com.BluHome.FanActionWithSiri", optionalDirectory: "FanCntrol")
    
    override init(){
       super.init()
        
        initBleProcess()
    }
    
    func initBleProcess(){
        
        self.centralManager = CBCentralManager.init(delegate: self, queue: DispatchQueue.main)
        
         SiriFanMemory.passMessageObject(999 as NSCoding, identifier: "FanCntrol")
        
        
        SiriFanMemory.listenForMessage(withIdentifier: "FanCntrol") { (message) in
            if let message : AnyObject = message as AnyObject?{
                if message as! Int == 999{
                    print("Device not connected")
                }else{
                    self.changeFanSpeed(message as! Int)
                    print("message came form siri \(message as! Int)")
                }
                
            }
        }
        
        
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if centralManager.state == .poweredOn{
            print("Bluetooth is On")
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            
        }else if centralManager.state == .poweredOff{
            print("Bluetooth is Off")
        }
        
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print(peripheral.name)
        
        //Connect with your own device
        if peripheral.name == "BluHome"{
            centralManager.connect(peripheral, options: nil)
            
        }else{
            print("This is not your devcie")
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Device Connected")
        
        self.connectedDevicePeripheral = peripheral
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Device Disconnected")
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        peripheral.services?.forEach({ (ser) in
            print(ser.uuid)
            peripheral.discoverCharacteristics(nil, for: ser)
        })
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        service.characteristics?.forEach({ (characteristic) in
            
            switch characteristic.uuid.uuidString {
                
            case fanSpeedCharUUID:
                   print("FanSpeed Char found")
                   self.fanSpeedChar = characteristic
                   
                   SiriFanMemory.passMessageObject(2 as NSCoding, identifier: "FanCntrol")
                
            case batteryCharUUID:
                print("Battery Char found")
                
            default:
                print("Unknown Char found")
                
                
            }
        })
    }
    
   
    
    
    func changeFanSpeed(_ speed : Int){
        
            var speed = speed
            let data = Data(bytes: &speed,count: MemoryLayout.size(ofValue: speed))
            connectedDevicePeripheral?.writeValue(data, for: fanSpeedChar!, type: .withResponse)
           
            
    }
       
    
    
    
    
    
    
    
}
