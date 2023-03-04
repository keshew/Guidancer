import Foundation

protocol GuestViewModelProtocol: AnyObject {
    static var shared: GuestViewModel { get }
    init()
    var postInforamtion: Post? { get set}
}

final class GuestViewModel: GuestViewModelProtocol {
    static var shared = GuestViewModel()
    init() {}
    var postInforamtion: Post?
}

