//
//  ViewController.swift
//  stackatada
//
//  Created by Mac User on 4/17/16.
//  Copyright © 2016 Ajackster. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = ""
    }
    
    @IBOutlet weak var numberLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("buttonSound", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        numberLbl.text = runningNumber
        
    }
    @IBAction func onClearPressed(sender: AnyObject) {
        numberLbl.text = "0"
        runningNumber = ""
        rightValStr = ""
        leftValStr = ""
        currentOperation = Operation.Empty
        result = ""
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(operation: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            if(runningNumber != ""){
            rightValStr = runningNumber
            runningNumber = ""
            
            switch currentOperation {
                case Operation.Multiply:
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                break
                case Operation.Divide:
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    break
                case Operation.Add:
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    break
                case Operation.Subtract:
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    break
                default:
                    break
            }
            leftValStr = result
            numberLbl.text = result
            }
        }else{
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    func playSound() {
        if(btnSound.playing) {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

