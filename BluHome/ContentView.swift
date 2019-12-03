//
//  ContentView.swift
//  BluHome
//
//  Created by mohammad mugish on 03/12/19.
//  Copyright © 2019 mohammad mugish. All rights reserved.
//

import SwiftUI
import UIKit
import Intents
import IntentsUI


struct ContentView: View {
    var body: some View {
        RedIntegratedConroller()
    }
}


//Stemp One
class RedController : UIViewController, UITableViewDelegate, UITableViewDataSource, INUIAddVoiceShortcutViewControllerDelegate{
    
    private var myTableView: UITableView!
    
    var allActionsFromSiri = [
        "Change fan speed to low",
        "Change fan speed to normal",
        "Change fan speed to high",
        "Turn off the fan",
        "Turn on the fan"
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
        BluetoothManager()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allActionsFromSiri.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel?.font = UIFont(name: "SFProText-Semibold", size: 11)
        cell.textLabel!.text = "\(allActionsFromSiri[indexPath.row])"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch allActionsFromSiri[indexPath.row] {
            
        case allActionsFromSiri[0]:
            addToSiri(allActionsFromSiri[indexPath.row])
            
        case allActionsFromSiri[1]:
            addToSiri(allActionsFromSiri[indexPath.row])
            
        case allActionsFromSiri[2]:
            addToSiri(allActionsFromSiri[indexPath.row])
            
        case allActionsFromSiri[3]:
            addToSiri(allActionsFromSiri[indexPath.row])
            
        case allActionsFromSiri[4]:
            addToSiri(allActionsFromSiri[indexPath.row])
            
            
        default:
            print("Something wrong with table view cell siri")
        }
        
        
    }
    
    func addToSiri(_ suggentedPhrase : String) {
        
        var intent : INIntent?
        
        switch suggentedPhrase {
            
        case allActionsFromSiri[0]:
            print("not in use Bluarmor help me")
            intent = ChangeSpeedToLowIntent()
            
            
        case allActionsFromSiri[1]:
            intent = ChangeSpeedToNormalIntent()
            
        case allActionsFromSiri[2]:
            intent = ChangeSpeedToHighIntent()
            
        case allActionsFromSiri[3]:
            intent = TurnOffTheFanIntent()
            
        case allActionsFromSiri[4]:
            intent = TurnOnTheFanIntent()
            
            
            
        default:
            print("No intent found")
        }
        
        
        intent!.suggestedInvocationPhrase = suggentedPhrase
        if let shortcut = INShortcut(intent: intent!) {
            
            
            let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            viewController.modalPresentationStyle = .formSheet
            viewController.delegate = self // Object conforming to `INUIAddVoiceShortcutViewControllerDelegate`.
            present(viewController, animated: true, completion: nil)
            
            //               INUIEditVoiceShortcutViewController(voiceShortcut: voiceShortcut)
            //                viewController.modalPresentationStyle = .formSheet
            //                viewController.delegate = self // Object conforming to `INUIAddVoiceShortcutViewControllerDelegate`.
            //                present(viewController, animated: true, completion: nil)
        }
        
    }
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true) {
            
        }
        //        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}

extension RedController: INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
    
}


//Step two
struct RedIntegratedConroller : UIViewControllerRepresentable{
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<RedIntegratedConroller>) -> RedController {
        return RedController()
    }
    
    func updateUIViewController(_ uiViewController: RedController, context: UIViewControllerRepresentableContext<RedIntegratedConroller>) {
        
    }
    
    
    typealias UIViewControllerType = RedController
    
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
