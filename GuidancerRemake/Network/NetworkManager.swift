import UIKit

protocol NetworkManagerProtocol: AnyObject {
    func getPost(completion: @escaping (Result<Post, Error>) -> Void)
    func loginInAccount(email: String, password: String, sucsessCompletion: @escaping (Result<Author, Error>) -> Void, faillureCompletion:  @escaping () -> ())
    func registerAccount(email: String, password: String, nickname: String, sucsessCompletion: @escaping () -> (), faillureCompletion:  @escaping () -> ())
    func deletePost(id: String)
    func editPost(id: String, location: String?, title: String?, description: String?)
}

fileprivate enum APIType {
    
    case getPost
    case loginInAccount
    case registerAccount
    case deletePost
    
    var path: String {
        switch self {
        case .getPost: return "posts"
        case .loginInAccount: return "auth/login"
        case .registerAccount: return "auth/register"
        case .deletePost: return "posts"
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
    
    func loginInAccount(email: String, password: String, sucsessCompletion: @escaping (Result<Author, Error>) -> Void, faillureCompletion:  @escaping () -> ()) {
        let parameters = ["email": email, "password": password]
        var request = APIType.loginInAccount.request
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse?.statusCode != 200 {
                    faillureCompletion()
                }
                guard let data else { return }
                do {
                    let json2 = try JSONDecoder().decode(Author.self, from: data)
                    sucsessCompletion(.success(json2))
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func registerAccount(email: String, password: String, nickname: String, sucsessCompletion: @escaping () -> (), faillureCompletion:  @escaping () -> ()) {
        let parameters = ["email": email, "password": password, "nickname": nickname, "avatarUrl": "https://inventrade.ru/upload/iblock/eb4/eb4fb522967a294ff36f1837bd60fd76.jpg"]
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
    
    func deletePost(id: String) {
        guard let url = URL(string: "http://31.31.203.226:4444/posts/\(id)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mzk2YmFlZDJmMjMzNjg0YzIyOGY0OTYiLCJpYXQiOjE2Nzg0NzQ0MjksImV4cCI6MTY4MTA2NjQyOX0.ywVOpubpCEaJR1IHULn3JCl2Uc2pC-4IFu_dj-h3NUU", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 200 {
                    print(httpResponse.statusCode)
                }
            }
        }
        task.resume()
    }
    
    func editPost(id: String, location: String?, title: String?, description: String?) {
        guard let url = URL(string: "http://31.31.203.226:4444/posts/\(id)") else {
            return
        }
        let data = ["title": title, "location": location, "text": description]
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mzk2YmFlZDJmMjMzNjg0YzIyOGY0OTYiLCJpYXQiOjE2Nzg0NzQ0MjksImV4cCI6MTY4MTA2NjQyOX0.ywVOpubpCEaJR1IHULn3JCl2Uc2pC-4IFu_dj-h3NUU", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                print("Response: \(String(data: data, encoding: .utf8)!)")
            }
        }
        task.resume()
    }
}
