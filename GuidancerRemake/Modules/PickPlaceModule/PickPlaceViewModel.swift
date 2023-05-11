import Foundation

protocol PickPlaceViewModelProtocol: AnyObject {
    static var shared: PickPlaceViewModel { get }
    init()
//    var PickPlaceViewModel: NetworkModel? { get set}
}

final class PickPlaceViewModel: PickPlaceViewModelProtocol {
    static var shared = PickPlaceViewModel()
    init() {}
//    var PickPlaceViewModel: NetworkModel?
}
