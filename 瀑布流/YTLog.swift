//
//  YTLog.swift
//  Swift-test
//
//  Created by Bill on 2017/5/11.
//  Copyright © 2017年 Bill. All rights reserved.
//

import UIKit

    
func YTLog<T>(_ message : T, file : String = #file, function: String = #function, lineNum : Int = #line ) {
    
    #if DEBUG
    
    let fileName = ( file as NSString ).lastPathComponent
    print("\(fileName) : \(lineNum) -- \(message)")
    
    #endif
}

 
