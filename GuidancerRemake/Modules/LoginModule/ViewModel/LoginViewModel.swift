import Foundation

protocol LoginViewModelProtocol: AnyObject {
    static var shared: LoginViewModel { get }
    init()
//    var loginViewModel: NetworkModel? { get set}
}

final class LoginViewModel: LoginViewModelProtocol {
    static var shared = LoginViewModel()
    init() {}
//    var loginViewModel: NetworkModel?
}
