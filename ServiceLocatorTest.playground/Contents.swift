import Foundation

protocol AuthenticationService {
    
    func login(username: String, password: String) -> Bool
    
}

protocol NotificationService {
    
    func sendNotification(message: String)
}

class AuthenticationServiceImpl: AuthenticationService {
    
    func login(username: String, password: String) -> Bool {
        print("Login with username: \(username), password: \(password)")
        return true
    }

}

class NotificationServiceImpl: NotificationService {
    
    func sendNotification(message: String) {
        print("Sending notification: \(message)")
    }
}

class ServiceLocator {
    
    static let shared = ServiceLocator()
    
    private init() {}
    
    func getAuthenticationService() -> AuthenticationService {
        return AuthenticationServiceImpl()
    }
    
    func getNotificationService() -> NotificationService {
        return NotificationServiceImpl()
    }
}

class LoginViewController {
    
    private let authenticationService: AuthenticationService
    
    init() {
        authenticationService = ServiceLocator.shared.getAuthenticationService()
    }
    
    func loginButtonTapped() {
        let username = "admin"
        let password = "password123"
        
        if authenticationService.login(username: username, password: password) {
            showHomeScreen()
        } else {
            showError()
        }
    }
    
    private func showHomeScreen() {
        print("Showing home screen")
    }
    
    private func showError() {
        print("Login failed")
    }
}

class NotificationSender {
    
    private let notificationService: NotificationService
    
    init() {
        notificationService = ServiceLocator.shared.getNotificationService()
    }
    
    func sendNotification(message: String) {
        notificationService.sendNotification(message: message)
    }
}

func main() {
    
    let loginViewController = LoginViewController()
    loginViewController.loginButtonTapped()
    
    let notificationSender = NotificationSender()
    notificationSender.sendNotification(message: "Hello, world!")
}

main()

