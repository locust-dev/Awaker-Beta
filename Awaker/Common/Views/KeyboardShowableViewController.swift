//
//  KeyboardShowableViewController.swift
//  MobileShip
//
//  Created by Ilya Turin on 09.01.2022.
//

import UIKit

class KeyboardShowableViewController: UIViewController {
    
    // MARK: - Properties
    
    private var activeTextField: UITextField?
    
    private let notificationCenter = NotificationCenter.default
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
    // MARK: - Public methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    // MARK: - Actions
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey],
              let keyboardSize = (keyboardFrame as? NSValue)?.cgRectValue,
              let activeTextField = activeTextField
        else {
            return
        }
        
        let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: view).maxY
        let topOfKeyboard = view.frame.height - keyboardSize.height
        
        if bottomOfTextField > topOfKeyboard {
            view.frame.origin.y = -keyboardSize.height
            view.setNeedsLayout()
        }
    }
    
    @objc private func keyboardWillHide() {
        view.frame.origin.y = 0
        view.setNeedsLayout()
    }
    
}

// MARK: - UITextFieldDelegate
extension KeyboardShowableViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}
