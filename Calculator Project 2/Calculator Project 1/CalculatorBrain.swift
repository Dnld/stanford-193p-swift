//
//  CalculatorBrain.swift
//  Calculator Project 1
//
//  Created by Donald Steinert on 11/10/15.
//  Copyright © 2015 Donald Steinert. All rights reserved.
//

import Foundation

class CalculatorBrain {

    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return  symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var opsStack = [Op]()
    
    private var knownOps = [String: Op]()
    
    init() {
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷", {$1 / $0})
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["-"] = Op.BinaryOperation("-", {$1 - $0})
        knownOps["√"] = Op.UnaryOperation("√", {sqrt($0)})
    }
    
    private func evaluateRecurs(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluateRecurs(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluateRecurs(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluateRecurs(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluateRecurs(opsStack)
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opsStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opsStack.append(operation)
        }
        return evaluate()
    }
    
}
