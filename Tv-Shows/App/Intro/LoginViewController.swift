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
    
    private var viewModel: LoginViewModel?
    private var rememberMeToggle: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginApi = LoginService()
        self.viewModel = LoginViewModel(with: nil, apiService: loginApi)
        self.bindViewModel(with: viewModel)
    }
    
    override func bindViewModel(with viewModel: BaseViewModel?) {
        super.bindViewModel(with: viewModel)
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
}

extension LoginViewController: LoginDelegate {
    func onFail() {
        self.activityIndicator.stopAnimating()
        self.correctDisplayAlert(title: "Error", message: "There's a network error, could you wait a few seconds and try again")
    }
    
    func onLoginSuccessful(response: LoginDataModel) {
        AccountManager.shared.setToken(with: response)
        self.activityIndicator.stopAnimating()
        guard let homeVC = StaticBoards.main.instantiateViewController(identifier: VCIDS.homeVC.rawValue) as? HomeViewController else { return }
        self.present(homeVC, animated: true, completion: nil)
    }
}

