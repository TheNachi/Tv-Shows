//
//  AccountManagerTests.swift
//  Tv-ShowsTests
//
//  Created by Munachimso Ugorji on 16/01/2021.
//

import XCTest
@testable import Tv_Shows

class AccountManagerTests: XCTestCase {

    func testLogin() {
        XCTAssertFalse(AccountManager.shared.isLoggedIn())
        AccountManager.shared.setToken(with: LoginDataModel())
        XCTAssertTrue(AccountManager.shared.isLoggedIn())
        AccountManager.shared.logOut()
        XCTAssertFalse(AccountManager.shared.isLoggedIn())
    }
}
