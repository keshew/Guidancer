import Foundation

protocol NotificationViewModelProtocol: AnyObject {
    static var shared: NotificationViewModel { get }
    init()
//    var NotificationViewModel: NetworkModel? { get set}
}

final class NotificationViewModel: NotificationViewModelProtocol {
    static var shared = NotificationViewModel()
    init() {}
//    var NotificationViewModel: NetworkModel?
}
