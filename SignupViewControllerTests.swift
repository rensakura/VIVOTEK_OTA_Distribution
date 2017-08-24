//
//  SignupViewControllerTests.swift
//  iViewer
//
//  Created by davis.cho on 2017/8/18.
//  Copyright © 2017年 Vivotek. All rights reserved.
//

import XCTest
@testable import iViewer

class SignupViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Test states
    
    func testTextfieldValue() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        let state = SignupViewController.State(username: "username", password: "password", confirmPassword: "confirmPassword", isShowingNotificationMessage: false, notificationMessage: "", isHighlightUsernameField: false, ishighlightPasswordField: false, ishighlightConfirmPasswordField: false, isLoading: false, isShowingSignupSuccessAlert: false, isShowingSignupFailureAlert: false, alertMessage: "", isPresentingPrivacyPolicy: false)
        
        vc.stateDidChanged(state: state, previousState: nil)
        
        XCTAssertTrue(vc.usernameField.text == "username")
        XCTAssertTrue(vc.passwordField.text == "password")
        XCTAssertTrue(vc.confirmPasswordField.text == "confirmPassword")
    }
    
    func testNotificationMessage() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        let state = SignupViewController.State(username: "", password: "", confirmPassword: "", isShowingNotificationMessage: true, notificationMessage: "ErrorMessage", isHighlightUsernameField: false, ishighlightPasswordField: false, ishighlightConfirmPasswordField: false, isLoading: false, isShowingSignupSuccessAlert: false, isShowingSignupFailureAlert: false, alertMessage: "", isPresentingPrivacyPolicy: false)
        
        vc.stateDidChanged(state: state, previousState: nil)
        
        XCTAssertTrue(TSMessage.isNotificationActive())
    }
    
    func testTextfieldHighlight() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        let state = SignupViewController.State(username: "", password: "", confirmPassword: "", isShowingNotificationMessage: false, notificationMessage: "", isHighlightUsernameField: true, ishighlightPasswordField: true, ishighlightConfirmPasswordField: true, isLoading: false, isShowingSignupSuccessAlert: false, isShowingSignupFailureAlert: false, alertMessage: "", isPresentingPrivacyPolicy: false)
        
        vc.stateDidChanged(state: state, previousState: nil)

        XCTAssertTrue(vc.usernameField.style == .highlight)
        XCTAssertTrue(vc.passwordField.style == .highlight)
        XCTAssertTrue(vc.confirmPasswordField.style == .highlight)
        
        let state2 = SignupViewController.State(username: "", password: "", confirmPassword: "", isShowingNotificationMessage: false, notificationMessage: "", isHighlightUsernameField: false, ishighlightPasswordField: false, ishighlightConfirmPasswordField: false, isLoading: false, isShowingSignupSuccessAlert: false, isShowingSignupFailureAlert: false, alertMessage: "", isPresentingPrivacyPolicy: false)
        
        vc.stateDidChanged(state: state2, previousState: state)
        
        XCTAssertTrue(vc.usernameField.style == .normal)
        XCTAssertTrue(vc.passwordField.style == .normal)
        XCTAssertTrue(vc.confirmPasswordField.style == .normal)
    }
    
    func testLoading() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        let state = SignupViewController.State(username: "", password: "", confirmPassword: "", isShowingNotificationMessage: false, notificationMessage: "", isHighlightUsernameField: false, ishighlightPasswordField: false, ishighlightConfirmPasswordField: false, isLoading: true, isShowingSignupSuccessAlert: false, isShowingSignupFailureAlert: false, alertMessage: "", isPresentingPrivacyPolicy: false)
        
        vc.stateDidChanged(state: state, previousState: nil)
        
        XCTAssertTrue(SVProgressHUD.isVisible())
    }
    
    func testSignupSuccessAlertView() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        let state = SignupViewController.State(username: "", password: "", confirmPassword: "", isShowingNotificationMessage: false, notificationMessage: "", isHighlightUsernameField: false, ishighlightPasswordField: false, ishighlightConfirmPasswordField: false, isLoading: false, isShowingSignupSuccessAlert: true, isShowingSignupFailureAlert: false, alertMessage: "", isPresentingPrivacyPolicy: false)
        
        vc.stateDidChanged(state: state, previousState: nil)
        
        let alertView = VVTKAlertView.visible()
        XCTAssertTrue(alertView != nil)
        XCTAssertTrue(alertView?.titleLabel.text == NSLocalizedString("Successful", comment: ""))
        XCTAssertTrue(alertView?.descriptionLabel.text == NSLocalizedString("check_email_to_activate_your_account_within_30_mins_or_another_signup_is_required", comment: ""))
    }
    
    func testSignupFailureAlertView() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        let state = SignupViewController.State(username: "", password: "", confirmPassword: "", isShowingNotificationMessage: false, notificationMessage: "", isHighlightUsernameField: false, ishighlightPasswordField: false, ishighlightConfirmPasswordField: false, isLoading: false, isShowingSignupSuccessAlert: false, isShowingSignupFailureAlert: true, alertMessage: "error", isPresentingPrivacyPolicy: false)
        
        vc.stateDidChanged(state: state, previousState: nil)
        
        let alertView = VVTKAlertView.visible()
        XCTAssertTrue(alertView != nil)
        XCTAssertTrue(alertView?.titleLabel.text == NSLocalizedString("failed_to_sign_up", comment: ""))
        XCTAssertTrue(alertView?.descriptionLabel.text == "error")
    }
    
    func testPrivacyPolicy() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        UIApplication.shared.keyWindow?.rootViewController = vc
        
        let state = SignupViewController.State(username: "", password: "", confirmPassword: "", isShowingNotificationMessage: false, notificationMessage: "", isHighlightUsernameField: false, ishighlightPasswordField: false, ishighlightConfirmPasswordField: false, isLoading: false, isShowingSignupSuccessAlert: false, isShowingSignupFailureAlert: false, alertMessage: "", isPresentingPrivacyPolicy: true)
        
        vc.stateDidChanged(state: state, previousState: nil)
        
        let alertView = vc.presentedViewController as! VVTKTextViewAlertViewController
        XCTAssertTrue(alertView.title == NSLocalizedString("privacy_policy", comment: ""))
        XCTAssertTrue(alertView.textView.text == "Thanks for using VIVOTEK VIVOCloud Service! We, VIVOTEK Inc., will protect your online privacy with our best efforts. Please be advised that by your registration of VIVOTEK VIVOCloud account, you have fully reviewed the following terms and conditions of this Privacy Policy and formally agree it. If you have any comments or questions, please contact us at technical@vivotek.com.\n\nData Collection\nWe collect and use the following information to provide, improve and protect our Services:\n\n- Account\nWe collect and associate with your account to your information, including, but not limited to email address, name, payment information you provided when register.\n\n-Usage\nWe collect information, including, but not limited to IP address, type of browser and device, identifiers associated with your devices. Your devices may also transmit location information to the services.\n\n-Cookies\nWe use cookies and pixel tags to help us improving our service. Cookies remembering your username for your next visit, understanding how you are interacting with our service. You can set your browser to not accept cookies, but this may limit your ability to use the services.\n\nData or Content Sharing\nVIVOTEK will not disclose your personal information you provided, usage information when you use service, or any pixel tags, cookies to any third-parties without your prior consent. However, you may share your content (device access authority, video and audio stream or recording data) to other VIVOTEK VIVOCloud user in your sole discretion.\n\nLimited Liability\nWe will in no event be liable under this Privacy Policy and the services to you for any indirect, incidental, special, consequential, or punitive damages, whether foreseeable or unforeseeable, of any kind whatsoever, whether based on warranty, contract, tort (including negligence) or any other legal equitable theory, even if it has been advised of the possibility of such damages. Our aggregate liability to you for losses, damages, costs, expenses, and other amounts arising out of or relating to this Privacy Policy and the services, regardless of the theory of liability, will in no event exceed the amount paid by you.\n\nChanges\nWe reserve the rights to revise this Privacy Policy from time to time, and will post the most current version on our website.\n")
    }
    
    // Test actions
    
    func testValidInput() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        let state = SignupViewController.State(username: "davis.cho", password: "123", confirmPassword: "123", isShowingNotificationMessage: false, notificationMessage: "", isHighlightUsernameField: false, ishighlightPasswordField: false, ishighlightConfirmPasswordField: false, isLoading: false, isShowingSignupSuccessAlert: false, isShowingSignupFailureAlert: false, alertMessage: "", isPresentingPrivacyPolicy: false)
        
        vc.stateDidChanged(state: state, previousState: nil)
        
        XCTAssertFalse(vc.isValidInput())
        XCTAssertTrue(vc.store.state.isShowingNotificationMessage)
        XCTAssertEqual(vc.store.state.notificationMessage, NSLocalizedString("email_format_is_incorrect", comment: ""))
        XCTAssertTrue(vc.store.state.isHighlightUsernameField)
        XCTAssertFalse(vc.store.state.ishighlightPasswordField)
        XCTAssertFalse(vc.store.state.ishighlightConfirmPasswordField)
        
        let state1 = SignupViewController.State(username: "davis.cho@vivotek.com", password: "123", confirmPassword: "123", isShowingNotificationMessage: false, notificationMessage: "", isHighlightUsernameField: false, ishighlightPasswordField: false, ishighlightConfirmPasswordField: false, isLoading: false, isShowingSignupSuccessAlert: false, isShowingSignupFailureAlert: false, alertMessage: "", isPresentingPrivacyPolicy: false)
        
        vc.stateDidChanged(state: state1, previousState: state)
        
        XCTAssertFalse(vc.isValidInput())
        XCTAssertTrue(vc.store.state.isShowingNotificationMessage)
        XCTAssertEqual(vc.store.state.notificationMessage, NSLocalizedString("limit_your_password_length_within_8_16_letters", comment: ""))
        XCTAssertFalse(vc.store.state.isHighlightUsernameField)
        XCTAssertTrue(vc.store.state.ishighlightPasswordField)
        XCTAssertFalse(vc.store.state.ishighlightConfirmPasswordField)
        
        let state2 = SignupViewController.State(username: "davis.cho@vivotek.com", password: "12345678", confirmPassword: "87654321", isShowingNotificationMessage: false, notificationMessage: "", isHighlightUsernameField: false, ishighlightPasswordField: false, ishighlightConfirmPasswordField: false, isLoading: false, isShowingSignupSuccessAlert: false, isShowingSignupFailureAlert: false, alertMessage: "", isPresentingPrivacyPolicy: false)
        
        vc.stateDidChanged(state: state2, previousState: state1)
        
        XCTAssertFalse(vc.isValidInput())
        XCTAssertTrue(vc.store.state.isShowingNotificationMessage)
        XCTAssertEqual(vc.store.state.notificationMessage, NSLocalizedString("passwords_do_not_match", comment: ""))
        XCTAssertFalse(vc.store.state.isHighlightUsernameField)
        XCTAssertTrue(vc.store.state.ishighlightPasswordField)
        XCTAssertTrue(vc.store.state.ishighlightConfirmPasswordField)
    }
    
    func testUsernameFieldEditingChanged() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        vc.usernameField.text = "davis.cho"
        vc.usernameFieldEditingChanged(vc.usernameField)
        
        XCTAssertEqual(vc.store.state.username, "davis.cho")
    }
    
    func testPasswordFieldEditingChanged() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        vc.passwordField.text = "12345678"
        vc.passwordFieldEditingChanged(vc.passwordField)
        
        XCTAssertEqual(vc.store.state.password, "12345678")
    }
    
    func testConfirmPasswordFieldEditingChanged() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        vc.confirmPasswordField.text = "12345678"
        vc.confirmPasswordFieldEditingChanged(vc.confirmPasswordField)
        
        XCTAssertEqual(vc.store.state.confirmPassword, "12345678")
    }
    
    func testSignupButtonDidTouch() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        vc.usernameField.text = "davis.cho@vivotek.com"
        vc.usernameFieldEditingChanged(vc.usernameField)
        vc.passwordField.text = "12345678"
        vc.passwordFieldEditingChanged(vc.passwordField)
        vc.confirmPasswordField.text = "12345678"
        vc.confirmPasswordFieldEditingChanged(vc.confirmPasswordField)
        
        vc.signupButtonDidTouch(vc.signupButton)
        
        XCTAssertTrue(vc.store.state.isLoading)
    }
    
    func testPrivacyButtonDidTouch() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        UIApplication.shared.keyWindow?.rootViewController = vc
        
        vc.privacyButtonDidTouch(vc)
        
        XCTAssertTrue(vc.store.state.isPresentingPrivacyPolicy)
    }
    
    func testSignupDidSuccess() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        vc.usernameField.text = "davis.cho@vivotek.com"
        vc.usernameFieldEditingChanged(vc.usernameField)
        vc.passwordField.text = "12345678"
        vc.passwordFieldEditingChanged(vc.passwordField)
        vc.confirmPasswordField.text = "12345678"
        vc.confirmPasswordFieldEditingChanged(vc.confirmPasswordField)
        
        vc.signupDidSuccess(notification: NSNotification(name: NSNotification.Name(rawValue: PortalService.notificationID(toString: PortalNotificationID.signupSuccessNotification)), object: nil, userInfo: nil))
        
        XCTAssertFalse(vc.store.state.isLoading)
        XCTAssertTrue(vc.store.state.isShowingSignupSuccessAlert)
        
        XCTAssertEqual(UserDefaults.standard.string(forKey: "username"), "davis.cho@vivotek.com")
        XCTAssertEqual(SSKeychain.password(forService: Bundle.main.bundleIdentifier, account: "davis.cho@vivotek.com"), "12345678")
    }
    
    func testSignupDidFail() {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        let _ = vc.view
        
        vc.signupDidFail(notification: NSNotification(name: NSNotification.Name(rawValue: PortalService.notificationID(toString: PortalNotificationID.signupFailureNotification)), object: nil, userInfo: ["Message": "error"]))
        
        XCTAssertFalse(vc.store.state.isLoading)
        XCTAssertTrue(vc.store.state.isShowingSignupFailureAlert)
        XCTAssertEqual(vc.store.state.alertMessage, "error")
    }
}
