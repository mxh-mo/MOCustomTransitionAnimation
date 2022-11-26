//
//  MOExtensions.swift
//  MOCustomTransitionAnimation
//
//  Created by mikimo on 2022/11/26.
//  Copyright © 2022 mikimo. All rights reserved.
//

import Foundation

func moPrint(_ target: NSObject, _ line: Int, _ params: Any) {
    print("\(Date()): <\(type(of: target)), \(String(format: "%p", target))> \(line): \(params)")
}
