//
//  ZHSwiftLogs.swift
//  
//
//  Created by Zakk Hoyt on 6/18/15.
//
//

import UIKit

enum ZHSwiftLogType: String {
    case Info = "info"
    case Todo = "todo"
    case Debug = "debug"
    case Warning = "warning"
    case Error = "error"
    case Critical = "critical"
    case Trace = "trace"
    case Callstack = "callstack"
}

func ZHLog(type: ZHSwiftLogType, log: String, file: String = #file, function: String = #function, line: Int = #line) {
    let typeString: String = type.rawValue
    
    switch type {
    case .Info, .Todo, .Debug, .Warning, .Error:
        print("\(function):\(line) ***** \(typeString.uppercaseString): \(log)")
        break;
    case .Trace:
        print("\(function):\(line) ***** \(typeString.uppercaseString)")
        break;
    case .Callstack:
        print("\(function):\(line) ***** \(typeString.uppercaseString): \(log)\r\n",
            "\(NSThread.callStackSymbols())")
        break;
    case .Critical:
        print("\(function):\(line) ***** \(typeString.uppercaseString): \(log)")
        assert(false, "Assertion: Something went wrong")

        break;
    }
}


