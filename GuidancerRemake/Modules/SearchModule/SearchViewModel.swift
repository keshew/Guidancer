import Foundation

protocol SearchViewModelProtocol: AnyObject {
    static var shared: SearchViewModel { get }
    init()
    var searchViewModel: Post? { get set}
}

final class SearchViewModel: SearchViewModelProtocol {
    static var shared = SearchViewModel()
    init() {}
    var searchViewModel: Post?
}
