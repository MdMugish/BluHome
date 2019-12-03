//
//  IntentHandler.swift
//  Siri
//
//  Created by mohammad mugish on 03/12/19.
//  Copyright © 2019 mohammad mugish. All rights reserved.
//

import Intents
import MMWormhole

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension {
    
    
    
    let SiriFanMemory = MMWormhole(applicationGroupIdentifier: "group.com.BluHome.FanActionWithSiri", optionalDirectory: "FanCntrol")
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

extension IntentHandler : ChangeSpeedToLowIntentHandling {
    
    func handle(intent: ChangeSpeedToLowIntent, completion: @escaping (ChangeSpeedToLowIntentResponse) -> Void) {
        if intent.low == .low{
            
            let currnetValue =  SiriFanMemory.message(withIdentifier: "FanCntrol")
            switch currnetValue as! Int {
            case 1:
                completion(.failure(res: "Fan is already in slow speed"))
            case 999:
                 completion(.failure(res: "BluHome is not connected"))
            default:
                SiriFanMemory.passMessageObject(1 as NSCoding, identifier: "FanCntrol")
                completion(.success(res: "Fan speed is changed to low"))
            }
            
        }
    }
    
    
    
    func resolveLow(for intent: ChangeSpeedToLowIntent, with completion: @escaping (SpeedsResolutionResult) -> Void) {
        if intent.low == .low{
            completion(.success(with: intent.low))
        }
    }
    
}

extension IntentHandler : ChangeSpeedToNormalIntentHandling {
   
    
    func handle(intent: ChangeSpeedToNormalIntent, completion: @escaping (ChangeSpeedToNormalIntentResponse) -> Void) {
        if intent.normal == .normal{
            let currnetValue =  SiriFanMemory.message(withIdentifier: "FanCntrol")
            switch currnetValue as! Int {
            case 2:
                completion(.failure(res: "Fan is already in slow Normal"))
            case 999:
                completion(.failure(res: "BluHome is not connected"))
                
            default:
                SiriFanMemory.passMessageObject(2 as NSCoding, identifier: "FanCntrol")
                completion(.success(res: "Fan speed is changed to Normal"))
            }
        }
    }
    
    
    
    func resolveNormal(for intent: ChangeSpeedToNormalIntent, with completion: @escaping (SpeedsResolutionResult) -> Void) {
        if intent.normal == .normal {
            completion(.success(with: intent.normal))
        }
    }
    
    
    
}
 



extension IntentHandler : ChangeSpeedToHighIntentHandling {
    
    
    
    func handle(intent: ChangeSpeedToHighIntent, completion: @escaping (ChangeSpeedToHighIntentResponse) -> Void) {
        if intent.high == .high{
            
            let currnetValue =  SiriFanMemory.message(withIdentifier: "FanCntrol")
            switch currnetValue as! Int {
            case 3:
                completion(.failure(res: "Fan is already in slow High"))
            case 999:
                completion(.failure(res: "BluHome is not connected"))
                
            default:
                SiriFanMemory.passMessageObject(3 as NSCoding, identifier: "FanCntrol")
                completion(.success(res: "Fan speed is changed to high"))
            }
            
        }
    }
    
    
    func resolveHigh(for intent: ChangeSpeedToHighIntent, with completion: @escaping (SpeedsResolutionResult) -> Void) {
        if intent.high == .high{
            completion(.success(with: intent.high))
        }
    }
    
    
}



extension IntentHandler : TurnOnTheFanIntentHandling{
  
    
    func handle(intent: TurnOnTheFanIntent, completion: @escaping (TurnOnTheFanIntentResponse) -> Void) {
        if intent.on == .on{
            let currnetValue =  SiriFanMemory.message(withIdentifier: "FanCntrol")
            switch currnetValue as! Int {
            case 1...3:
                completion(.failure(res: "Fan is already On"))
            case 999:
                completion(.failure(res: "BluHome is not connected"))
            default:
                SiriFanMemory.passMessageObject(2 as NSCoding, identifier: "FanCntrol")
                completion(.success(res: "Turning on the fan"))
            }
        }
    }
    
    
    
    func resolveOn(for intent: TurnOnTheFanIntent, with completion: @escaping (SpeedsResolutionResult) -> Void) {
          if intent.on == .on{
            completion(.success(with: intent.on))
          }
      }
}


extension IntentHandler  : TurnOffTheFanIntentHandling{
    
    
    func handle(intent: TurnOffTheFanIntent, completion: @escaping (TurnOffTheFanIntentResponse) -> Void) {
        if intent.off == .off{
            
            let currnetValue =  SiriFanMemory.message(withIdentifier: "FanCntrol")
                  switch currnetValue as! Int {
                  case 0:
                      completion(.failure(res: "Fan is already Off"))
                case 999:
                    completion(.failure(res: "BluHome is not connected"))
                  default:
                      SiriFanMemory.passMessageObject(0 as NSCoding, identifier: "FanCntrol")
                      completion(.success(res: "Turning off the fan"))
                  }
            
        }
    }
    
    
      func resolveOff(for intent: TurnOffTheFanIntent, with completion: @escaping (SpeedsResolutionResult) -> Void) {
        if intent.off == .off{
            completion(.success(with: intent.off))
        }
      }
    
    
}
