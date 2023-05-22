import UIKit

protocol FollowersViewProtocol: AnyObject {
}

class FollowersViewController: UIViewController {
    
    private lazy var  tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        return table
    }()
    
    private lazy var toBackBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(dismissVC))
        item.tintColor = .black
        return item
    }()
    
    var presenter: FollowersPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

private extension FollowersViewController {
    func setupView() {
        navigationItem.leftBarButtonItem = toBackBarButtonItem
        title = "followers"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
}

extension FollowersViewController: FollowersViewProtocol {
}

extension FollowersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "test"
        cell.tintColor = .black
        return cell
    }
    
}
