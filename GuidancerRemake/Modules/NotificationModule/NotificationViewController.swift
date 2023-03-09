import UIKit

protocol NotificationViewProtocol: AnyObject {
}

class NotificationViewController: UIViewController {
    
    var presenter: NotificationPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notif"
        view.backgroundColor = .white
    }
}

extension NotificationViewController: NotificationViewProtocol {
}
