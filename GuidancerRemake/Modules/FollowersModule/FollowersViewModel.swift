import Foundation

protocol FollowersViewModelProtocol: AnyObject {
    static var shared: FollowersViewModel { get }
    init()
//    var FollowersViewModel: NetworkModel? { get set}
}

final class FollowersViewModel: FollowersViewModelProtocol {
    static var shared = FollowersViewModel()
    init() {}
//    var FollowersViewModel: NetworkModel?
}
