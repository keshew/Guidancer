import UIKit

protocol NetworkManagerProtocol: AnyObject {
    func getPost(completion: @escaping (Result<Post, Error>) -> Void)
}

fileprivate enum APIType {
    
    case getPost
    
    var path: String {
        switch self {
        case .getPost: return "posts"
//        case .getPost: return "random?number=20&apiKey=29b6b28f28904fc3a4946eed49a5833b&"
        }
    }
    
    var baseURL: String {
        return "http://31.31.203.226:4444/"
//        return "https://api.spoonacular.com/recipes/"
    }

    var url: URL {
        let url = URL(string: path, relativeTo: URL(string: baseURL))
        return url!
    }
    
    var request: URLRequest {
        let request = URLRequest(url: url)
        return request
    }
}

final class NetworkManager: NetworkManagerProtocol  {
    static let shared = NetworkManager()
    
    func getPost(completion: @escaping (Result<Post, Error>) -> Void) {
        let request = APIType.getPost.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                guard let data else { return }
                let obj = try JSONDecoder().decode(Post.self, from: data)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
