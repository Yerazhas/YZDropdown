//
//  YZCollapsedState.swift
//  YZDropdown
//
//  Created by Yerassyl Zhassuzakhov on 7/18/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

class CollapsedState: YZDropdownState {
    let context: YZDropdown
    
    required init(context: YZDropdown) {
        self.context = context
    }
    
    func toggle() {
        context.setState(to: ChangingState(context: context))
        context.setExpandedState()
    }
}
