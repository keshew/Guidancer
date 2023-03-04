import Foundation

protocol ProfileViewModelProtocol: AnyObject {
    static var shared: ProfileViewModel { get }
    init()
    var postInforamtion: Post? { get set}
}

final class ProfileViewModel: ProfileViewModelProtocol {
    static var shared = ProfileViewModel()
    init() {}
    var postInforamtion: Post?
}
