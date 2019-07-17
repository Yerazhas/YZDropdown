//
//  YZDropdownState.swift
//  YZDropdown
//
//  Created by Yerassyl Zhassuzakhov on 7/18/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

protocol YZDropdownState {
    var toggleAction: (() -> ())? { get set }
    func toggle()
}
