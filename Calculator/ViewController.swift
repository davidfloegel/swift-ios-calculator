//
//  ViewController.swift
//  Calculator
//
//  Created by David Floegel on 04/07/2016.
//  Copyright © 2016 David Floegel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var runningNumber: String = "0"
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation: Operation = Operation.Empty

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearAll(sender: AnyObject) {
        runningNumber = "0"
        currentOperation = Operation.Empty
        leftValStr = ""
        rightValStr = ""
        updateLabel()
    }
    
    @IBAction func numberPressed( btn: UIButton ) {
        if runningNumber == "0" {
            runningNumber = ""
        }
        
        runningNumber += "\( btn.tag )"
        updateLabel()
    }
    
    @IBAction func dotPressed(sender: AnyObject) {
        runningNumber += "."
        updateLabel()
    }
    
    @IBAction func onPercentagePress(sender: AnyObject) {
    }
    
    @IBAction func onDividePress(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onTimesPress(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onMinusPress(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onPlusPress(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPress(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onTogglePlusMinus(sender: AnyObject) {
        let onScreen = outputLbl.text
        if onScreen != "0" {
            let toDouble = Double(onScreen!)!
            
            leftValStr = toDouble > 0 ? "-\(toDouble)" : "\(abs(toDouble))"
            runningNumber = leftValStr
            outputLbl.text = runningNumber
        }
    }
    
    @IBAction func onConvertToPercentage(sender: AnyObject) {
        let val = outputLbl.text
        let toPercentage = abs(Double(val!)!) / 100
        leftValStr = "\(toPercentage)"
        outputLbl.text = leftValStr
    }
    
    
    func processOperation(op: Operation) {
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                // run some maths
                rightValStr = runningNumber
                runningNumber = ""
                
                
                var calcRes: Double = 0
                if currentOperation == Operation.Multiply {
                    calcRes = Double( leftValStr )! * Double( rightValStr )!
                } else if currentOperation == Operation.Divide {
                    calcRes = Double( leftValStr )! / Double( rightValStr )!
                } else if currentOperation == Operation.Add {
                    calcRes = Double( leftValStr )! + Double( rightValStr )!
                } else if currentOperation == Operation.Subtract {
                    calcRes = Double( leftValStr )! - Double( rightValStr )!
                }
            
                leftValStr = "\(calcRes)"
                outputLbl.text = leftValStr
            }
        } else {
            // first time pressing an operator
            leftValStr = runningNumber
            runningNumber = ""
        }
        
        currentOperation = op
    }
    
    func updateLabel() {
        outputLbl.text = runningNumber
    }
}

