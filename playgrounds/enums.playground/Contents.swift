//: Playground - noun: a place where people can play

import UIKit

enum FamilyMember: String {
    case Don
    case Nancy
    case Donald
    case Thomas
    case Perry
}

var dog: FamilyMember = FamilyMember.Perry

var currentMember = FamilyMember.Don
currentMember = dog

switch currentMember {
case .Don:
    print("the father")
case .Nancy:
    print("the mother")
case .Donald:
    print("the oldest son")
case .Thomas:
    print("the youngest son")
default:
    print("the dog's name is \(FamilyMember.Perry.rawValue)")
}
