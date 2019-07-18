//
//  YZDropdown.swift
//  YZDropdown
//
//  Created by Yerassyl Zhassuzakhov on 6/16/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class YZDropdown: UIView {
    var cornerRadius: CGFloat!
    var optionSelection: ((Int) -> ())?
    private let expandedIcon: UIImage?
    private var collapsedIcon: UIImage?
    private let optionButtons: [UIButton]
    private var state: YZDropdownState! {
        didSet {
            print(String(describing: state))
        }
    }
    
    init(options: [UIImage], expandedIcon: UIImage? = nil) {
        assert(!options.isEmpty, "Options array shouldn't be empty")
        var tempButtons = [UIButton]()
        collapsedIcon = options.first!
        for i in 0..<options.count {
            let icon = options[i]
            let button = UIButton(type: .system)
            button.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
            button.tag = i + 1
            tempButtons.append(button)
        }
        self.expandedIcon = expandedIcon
        self.optionButtons = tempButtons
        super.init(frame: .zero)
        setupInitialStackAndButtonActions()
        setupViews()
        state = CollapsedState(context: self)
    }
    
    init(options: [UIButton], expandedIcon: UIImage? = nil) {
        assert(!options.isEmpty, "Options array shouldn't be empty")
        collapsedIcon = options.first!.currentImage
        for i in 0..<options.count {
            options[i].tag = i + 1
        }
        self.expandedIcon = expandedIcon
        self.optionButtons = options
        super.init(frame: .zero)
        setupInitialStackAndButtonActions()
        setupViews()
        state = CollapsedState(context: self)
    }
    
    func toggle() {
        state.toggle()
    }
    
    func setState(to state: YZDropdownState) {
        self.state = state
    }
    
    private func setupInitialStackAndButtonActions() {
        optionsVStack.addArrangedSubview(optionButtons[0])
        optionButtons.forEach { (optionButton) in
            optionButton.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shouldSetBorder(true)
    }
    
    func setCollapsedState() {
        optionButtons[0].setImage(collapsedIcon!.withRenderingMode(.alwaysOriginal), for: .normal)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 15, options: .curveEaseInOut, animations: {
            for i in 1..<self.optionButtons.count {
                let timeInterval = 0.03
                DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval * Double(i), execute: {
                    let optionButton = self.optionButtons[i]
                    self.optionsVStack.removeArrangedSubview(optionButton)
                    optionButton.removeFromSuperview()
                    if i == self.optionButtons.count - 1 {
                        self.setState(to: CollapsedState(context: self))
                    }
                })
            }
        }) { (_) in }
    }
    
    func setExpandedState() {
        if let expandedIcon = expandedIcon {
            optionButtons[0].setImage(expandedIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 15, options: .curveEaseInOut, animations: {
            for i in 1..<self.optionButtons.count {
                let timeInterval = 0.03
                DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval * Double(i), execute: {
                    let optionButton = self.optionButtons[i]
                    self.optionsVStack.addArrangedSubview(optionButton)
                    if i == self.optionButtons.count - 1 {
                        self.setState(to: ExpandedState(context: self))
                    }
                })
            }
        }) { (_) in }
    }
    
    private func shouldSetBorder(_ should: Bool) {
        if should {
            addShadow(radius: bounds.width / 2)
        } else {
            removeShadow()
        }
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(optionsVStack)
        optionsVStack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        let index = sender.tag - 1
        optionSelection?(index)
    }
    
    lazy var optionsVStack: UIStackView = {
        let ovs = UIStackView()
        ovs.axis = .vertical
        ovs.distribution = .fillEqually
        ovs.spacing = 8
        
        return ovs
    }()
}
