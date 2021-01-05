//
//  ViewController.swift
//  OTP
//
//  Created by Macintosh on 04/01/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var OTPView: OTPView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OTPView.becomeFirstResponder()
        OTPView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFocusOnOTP(_:))))
        OTPView.addTarget(self, action: #selector(onEditingEnded(_:)), for: .editingDidEnd)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapGesture(_:))))
    }
    
    @objc
    private func onFocusOnOTP(_ sender: UITapGestureRecognizer) {
        OTPView.becomeFirstResponder()
    }
    
    @objc
    private func onEditingEnded(_ sender: OTPView) {
        print(sender.value)
        view.endEditing(true)
    }
    
    @objc
    private func onTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

