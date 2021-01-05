//
//  OTPView.swift
//  OTP
//
//  Created by Macintosh on 04/01/21.
//

import UIKit

@IBDesignable
class OTPView: UIControl, UIKeyInput {
    var value = ""
    private var nextTag = 1
    
    @IBInspectable
    var numberOfDigits: Int = 6 {
        didSet{
            self.setupViews()
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var spacing: CGFloat = 12 {
        didSet{
            pinsStack.spacing = spacing
            self.setupViews()
            self.layoutIfNeeded()
        }
    }
    
    var keyboardType: UIKeyboardType {
        get{
            return .numberPad
        }
        set{
            
        }
    }
    
    private lazy var pinsStack: UIStackView = {
        let sv = UIStackView.init()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fill
        sv.spacing = spacing
        return sv
    }()

    override var canBecomeFirstResponder: Bool {
        true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViewsToTheControl()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubViewsToTheControl()
        setupViews()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        addSubViewsToTheControl()
        setupViews()
    }
    
    private func addSubViewsToTheControl() {
        backgroundColor = .clear
        addSubview(pinsStack)
    }
    
    private func setupViews() {
        for pinView in pinsStack.arrangedSubviews {
            pinView.removeFromSuperview()
        }
        
        for cons in constraints {
            if cons.firstAttribute == .width {
                cons.isActive = false
            }
        }
        
        layoutIfNeeded()
        
        for tag in 1...numberOfDigits {
            let pin = UILabel()
            pin.text = "_"
            pin.textAlignment = .center
            pin.tag = tag
            pin.translatesAutoresizingMaskIntoConstraints = false
            pinsStack.addArrangedSubview(pin)
        }
        
        addConstraints([
            pinsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            pinsStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            pinsStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9, constant: 0),
            pinsStack.widthAnchor.constraint(equalTo: pinsStack.heightAnchor, multiplier: CGFloat(numberOfDigits), constant: (CGFloat(numberOfDigits - 1) * spacing))
        ])
        
        for pinnn in pinsStack.arrangedSubviews {
            guard let pin = pinnn as? UILabel else {return}
            pinsStack.addConstraints([
                pin.heightAnchor.constraint(equalTo: pinsStack.heightAnchor, multiplier: 1),
                pin.widthAnchor.constraint(equalTo: pin.heightAnchor, constant: 0)
            ])
        }
    }

    var hasText: Bool {
        return nextTag > 1 ? true : false
    }

    func insertText(_ text: String) {
        if nextTag < (numberOfDigits + 1) {
            value += text
            (viewWithTag(nextTag)! as! UILabel).text = text
            nextTag += 1
            if nextTag == (numberOfDigits + 1) {
                self.sendActions(for: .editingDidEnd)
            }
        }
    }

    func deleteBackward() {
        if nextTag > 1 {
            nextTag -= 1
            _ = value.popLast()
            (viewWithTag(nextTag)! as! UILabel).text = "_"
        }
    }
}
