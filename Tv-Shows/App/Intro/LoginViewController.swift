//
//  ViewController.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 11/01/2021.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordSecureImage: UIButton!
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logInButton: UIButton!
    
    private var viewModel: LoginViewModel?
    private var rememberMeToggle: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginApi = LoginService()
        self.viewModel = LoginViewModel(with: loginApi)
        self.bindViewModel(with: viewModel)
    }
    
    override func bindViewModel(with viewModel: BaseViewModel?) {
        super.bindViewModel(with: viewModel)
        guard isViewLoaded, let vModel = viewModel as? LoginViewModel else { return }
        self.addTargetToTextField()
        self.emailTextField.text = vModel.getSavedEmail()
        self.passwordTextField.text = vModel.getSavedPassword()
        self.textFieldEmptyCheck(sender: UITextField())
    }
    
    @IBAction func toggleSecurePassword(_ sender: UIButton) {
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
        let imageName = self.passwordTextField.isSecureTextEntry ? "ic-hide-password" : "ic-characters-hide"
        self.passwordSecureImage.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @IBAction func rememberMePressed(_ sender: UIButton) {
        let imageName = self.rememberMeToggle ? "ic-checkbox-empty" : "ic-checkbox-filled"
        self.rememberMeButton.setImage(UIImage(named: imageName), for: .normal)
        self.rememberMeToggle.toggle()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = self.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = self.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let vModel = self.viewModel else { return }
        
        if vModel.validateEmailAndPassword(email: email, password: password) {
            if vModel.emailIsValid(email: email) {
                self.activityIndicator.startAnimating()
                let loginModel = LoginModel()
                loginModel.email = email
                loginModel.password = password
                viewModel?.loginUser(with: loginModel, delegate: self)
            } else {
                self.correctDisplayAlert(title: "Error", message: "You've inputed a wrong email format, please correct it and try again")
            }
        } else {
            self.correctDisplayAlert(title: "Error", message: "Please ensure that no Field is left blank")
        }
        
    }
    
    @objc func textFieldEmptyCheck(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        guard let email = self.emailTextField.text, !email.isEmpty,
              let password = self.passwordTextField.text, !password.isEmpty
        else {
            self.logInButton.backgroundColor = UIColor.buttonUnselectedColor
            self.logInButton.isUserInteractionEnabled = false
            return
        }
        self.logInButton.backgroundColor = UIColor.buttonSelectedColor
        self.logInButton.isUserInteractionEnabled = true
    }
    
    func addTargetToTextField() {
        self.logInButton.backgroundColor = UIColor.buttonUnselectedColor
        self.logInButton.isUserInteractionEnabled = false
        self.emailTextField.addTarget(self, action: #selector(textFieldEmptyCheck), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textFieldEmptyCheck), for: .editingChanged)
    }
}

extension LoginViewController: LoginDelegate {
    func onFail() {
        self.activityIndicator.stopAnimating()
        self.correctDisplayAlert(title: "Error", message: "Ensure you inputed the correct email and password combination and try again")
    }
    
    func onLoginSuccessful(response: LoginDataModel) {
        if rememberMeToggle {
            guard let email = self.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  let password = self.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  let vModel = self.viewModel else { return }
            vModel.rememberMe(email: email, password: password)
        }
        AccountManager.shared.setToken(with: response)
        self.activityIndicator.stopAnimating()
        guard let homeVC = StaticBoards.main.instantiateViewController(identifier: VCIDS.homeVC.rawValue) as? HomeViewController else { return }
        self.present(homeVC, animated: true, completion: nil)
    }
}
