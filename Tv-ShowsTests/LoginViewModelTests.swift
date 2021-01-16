//
//  LoginViewModelTests.swift
//  Tv-ShowsTests
//
//  Created by Munachimso Ugorji on 16/01/2021.
//

import XCTest
@testable import Tv_Shows

class LoginViewModelTests: XCTestCase {

    override func tearDown() {
        super.tearDown()
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }

    func testValidateEmailAndPassword() {
        let viewModel = LoginViewModel(with: nil)
        XCTAssertTrue(viewModel.validateEmailAndPassword(email: "abc@hotmail.com", password: "hello"))
        XCTAssertFalse(viewModel.validateEmailAndPassword(email: "abc@hotmail.com", password: ""))
        XCTAssertFalse(viewModel.validateEmailAndPassword(email: "", password: "asd"))
        XCTAssertFalse(viewModel.validateEmailAndPassword(email: "", password: ""))
    }

    func testEmailIsValid() {
        let viewModel = LoginViewModel(with: nil)
        XCTAssertTrue(viewModel.emailIsValid(email: "abc@hotmail.com"))
        XCTAssertTrue(viewModel.emailIsValid(email: "a@1.com"))
        XCTAssertFalse(viewModel.emailIsValid(email: "az.com"))
        XCTAssertFalse(viewModel.emailIsValid(email: "@hotmail.com"))
    }

    func testRememberMe() {
        XCTAssertNil(UserDefaults.standard.string(forKey: "EMAIL"))
        XCTAssertNil(UserDefaults.standard.string(forKey: "PASSWORD"))

        let viewModel = LoginViewModel(with: nil)
        viewModel.rememberMe(email: "you@hotmail.com", password: "you'reahotmail")

        XCTAssertNotNil(UserDefaults.standard.string(forKey: "EMAIL"))
        XCTAssertNotNil(UserDefaults.standard.string(forKey: "PASSWORD"))
    }

    func testGetSavedEmail() {
        XCTAssertNotEqual(UserDefaults.standard.string(forKey: "EMAIL"), "you@hotmail.com")

        let viewModel = LoginViewModel(with: nil)
        viewModel.rememberMe(email: "you@hotmail.com", password: "you'reahotmail")

        XCTAssertEqual(viewModel.getSavedEmail(), "you@hotmail.com")
    }

    func testGetSavedPassword() {
        XCTAssertNotEqual(UserDefaults.standard.string(forKey: "PASSWORD"), "you'reahotmail")

        let viewModel = LoginViewModel(with: nil)
        viewModel.rememberMe(email: "you@hotmail.com", password: "you'reahotmail")

        XCTAssertEqual(viewModel.getSavedPassword(), "you'reahotmail")
    }
}
