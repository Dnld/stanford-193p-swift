//
//  ViewController.swift
//  Calculator Project 1
//
//  Created by Donald Steinert on 11/9/15.
//  Copyright © 2015 Donald Steinert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
  
    @IBOutlet weak var stackDisplay: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var decimalSelected = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if decimalSelected && digit == "." {
            return
        }
        if !userIsInTheMiddleOfTypingANumber && digit == "π" {
            display.text = "3.14"
            return
        }
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        if digit == "." {
            decimalSelected = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation {$0 * $1}
        case "÷": performOperation {$1 / $0}
        case "+": performOperation {$0 + $1}
        case "-": performOperation {$1 - $0}
        case "√": performSingleOperation {sqrt($0)}
        case "sin": performSingleOperation {sin($0)}
        case "cos": performSingleOperation {cos($0)}
        default: break
        }
        addToStackDisplay(operation)
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performSingleOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = [Double]()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        decimalSelected = false
        operandStack.append(displayValue)
        addToStackDisplay(String(displayValue))
    }
   
    @IBAction func clear() {
        display.text = "0"
        stackDisplay.text = "0"
        userIsInTheMiddleOfTypingANumber = false
        decimalSelected = false
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            decimalSelected = false
        }
    }
    
    func addToStackDisplay(input: String) {
        let addition = ", " + input
        print(addition)
        stackDisplay.text = stackDisplay.text! + addition
    }

}
