import Foundation

protocol PlacesViewModelProtocol: AnyObject {
    static var shared: PlacesViewModel { get }
    init()
//    var PlacesViewModel: NetworkModel? { get set}
}

final class PlacesViewModel: PlacesViewModelProtocol {
    static var shared = PlacesViewModel()
    init() {}
//    var PlacesViewModel: NetworkModel?
}
