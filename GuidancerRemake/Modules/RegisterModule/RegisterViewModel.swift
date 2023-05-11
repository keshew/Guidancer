import Foundation

protocol RegisterViewModelProtocol: AnyObject {
    static var shared: RegisterViewModel { get }
    init()
//    var RegisterViewModel: NetworkModel? { get set}
}

final class RegisterViewModel: RegisterViewModelProtocol {
    static var shared = RegisterViewModel()
    init() {}
//    var RegisterViewModel: NetworkModel?
}
