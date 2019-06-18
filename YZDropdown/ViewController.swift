//
//  ViewController.swift
//  YZDropdown
//
//  Created by Yerassyl Zhassuzakhov on 6/16/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(dropdown)
//        view.addSubview(dropdown1)
        dropdown.optionSelection = { [weak dropdown] (index) in
            print("option tapped at index: \(index)")
            dropdown?.changeExpandedState()
        }
//        dropdown1.optionSelection = { [weak dropdown1] (index) in
//            print("option tapped at index: \(index)")
//            dropdown1?.changeExpandedState()
//        }
        dropdown.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
//        dropdown1.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.left.equalTo(dropdown.snp.right).offset(20)
//        }
    }

    lazy var dropdown: YZDropdown = {
        let dd = YZDropdown(options: [#imageLiteral(resourceName: "Group 10567"), #imageLiteral(resourceName: "Group 10574"), #imageLiteral(resourceName: "Group 10546"), #imageLiteral(resourceName: "Group 10567"), #imageLiteral(resourceName: "Group 10574"), #imageLiteral(resourceName: "Group 10546"), #imageLiteral(resourceName: "Group 10567"), #imageLiteral(resourceName: "Group 10574"), #imageLiteral(resourceName: "Group 10546"), #imageLiteral(resourceName: "Group 10567"), #imageLiteral(resourceName: "Group 10574"), #imageLiteral(resourceName: "Group 10546")], expandedIcon: #imageLiteral(resourceName: "Group 10566"))
        
        return dd
    }()
    
    lazy var dropdown1: YZDropdown = {
        let dd = YZDropdown(options: [optionsButton, editButton, mapButton])
        
        return dd
    }()

    lazy var optionsButton: UIButton = {
        let ob = UIButton(type: .system)
        ob.setImage(#imageLiteral(resourceName: "Group 10567").withRenderingMode(.alwaysOriginal), for: .normal)
        
        return ob
    }()
    
    lazy var editButton: UIButton = {
        let eb = UIButton(type: .system)
        eb.setImage(#imageLiteral(resourceName: "Group 10574").withRenderingMode(.alwaysOriginal), for: .normal)
        
        return eb
    }()
    
    lazy var mapButton: UIButton = {
        let mb = UIButton(type: .system)
        mb.setImage(#imageLiteral(resourceName: "Group 10546").withRenderingMode(.alwaysOriginal), for: .normal)
        
        return mb
    }()
}

