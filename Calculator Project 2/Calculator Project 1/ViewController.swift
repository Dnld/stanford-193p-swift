//
//  ViewController.swift
//  Calculator Project 1
//
//  Created by Donald Steinert on 11/9/15.
//  Copyright © 2015 Donald Steinert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var brain = CalculatorBrain()

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
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
            addToStackDisplay(operation)
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        decimalSelected = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
            addToStackDisplay(String(displayValue))
        } else {
            displayValue = 0
        }
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
