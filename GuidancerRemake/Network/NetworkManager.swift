import UIKit

protocol NetworkManagerProtocol: AnyObject {
    func getPost(completion: @escaping (Result<Post, Error>) -> Void)
    func loginInAccount(email: String, password: String, sucsessCompletion: @escaping () -> (), faillureCompletion:  @escaping () -> ())
    func registerAccount(email: String, password: String, nickname: String, sucsessCompletion: @escaping () -> (), faillureCompletion:  @escaping () -> ()) 
}
//test@test.com
//test123
fileprivate enum APIType {
    
    case getPost
    case loginInAccount
    case registerAccount
    
    var path: String {
        switch self {
        case .getPost: return "posts"
        case .loginInAccount: return "auth/login"
        case .registerAccount: return "auth/register"
        }
        
    }
    
    var baseURL: String {
        return "http://31.31.203.226:4444/"
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
    
    func loginInAccount(email: String, password: String, sucsessCompletion: @escaping () -> (), faillureCompletion:  @escaping () -> ()) {
        let parameters = ["email": email, "password": password]
        var request = APIType.loginInAccount.request
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode
                {
                case HTTPStatusCodeGroup.Success.rawValue :
                    sucsessCompletion()
                default:
                    faillureCompletion()
                }
                guard let data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func registerAccount(email: String, password: String, nickname: String, sucsessCompletion: @escaping () -> (), faillureCompletion:  @escaping () -> ()) {
        let parameters = ["email": email, "password": password, "nickname": nickname]
        var request = APIType.registerAccount.request
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                let httpResponse = response as? HTTPURLResponse
                switch httpResponse?.statusCode
                {
                case HTTPStatusCodeGroup.Success.rawValue :
                    sucsessCompletion()
                default:
                    faillureCompletion()
                }
                guard let data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}

