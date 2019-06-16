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
    private let optionButtons: [UIButton]
    private var isExpanded = false {
        didSet {
            if isExpanded {
                setExpandedState()
            } else {
                setCollapsedState()
            }
        }
    }
    
    init(icons: [UIImage], expandedIcon: UIImage? = nil) {
        assert(!icons.isEmpty, "Icons array shouldn't be empty")
        var tempButtons = [UIButton]()
        for i in 0..<icons.count {
            let icon = icons[i]
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
    }
    
    init(optionButtons: [UIButton], expandedIcon: UIImage? = nil) {
        assert(!optionButtons.isEmpty, "OptionButtons array shouldn't be empty")
        for i in 0..<optionButtons.count {
            optionButtons[i].tag = i + 1
        }
        self.expandedIcon = expandedIcon
        self.optionButtons = optionButtons
        super.init(frame: .zero)
        setupInitialStackAndButtonActions()
        setupViews()
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
    
    func changeExpandedState() {
        isExpanded.toggle()
    }
    
    private func setCollapsedState() {
        optionButtons[0].setImage(#imageLiteral(resourceName: "Group 10567").withRenderingMode(.alwaysOriginal), for: .normal)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            for i in 1..<self.optionButtons.count {
                let timeInterval = 0.01
                DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval * Double(i), execute: {
                    let optionButton = self.optionButtons[i]
                    self.optionsVStack.removeArrangedSubview(optionButton)
                    optionButton.removeFromSuperview()
                })
            }
        }) { (_) in }
    }
    
    private func setExpandedState() {
        if let expandedIcon = expandedIcon {
            optionButtons[0].setImage(expandedIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 4, initialSpringVelocity: 7, options: .curveEaseInOut, animations: {
            for i in 1..<self.optionButtons.count {
                let timeInterval = 0.01
                DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval * Double(i), execute: {
                    let optionButton = self.optionButtons[i]
                    self.optionsVStack.addArrangedSubview(optionButton)
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
